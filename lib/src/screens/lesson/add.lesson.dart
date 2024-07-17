import 'dart:io';
import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/material.dart';

import '../../data/models/lesson.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';

import '../../resources/styles_manager.dart';

class AddLessonScreen extends StatefulWidget {
  AddLessonScreen({super.key});
  final Lesson? lesson = Get.arguments;

  @override
  State<AddLessonScreen> createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  final QuillController _controller = QuillController.basic();
  final formKey = GlobalKey<FormState>();
  final topicController = TextEditingController();
  final subtopicController = TextEditingController();
  File? _image;

  @override
  void initState() {
    if (widget.lesson != null) {
      topicController.text = widget.lesson!.topic;
      subtopicController.text = widget.lesson!.subtopic;
      _controller.document = Document.fromJson(widget.lesson!.body);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: CurvedScaffold(
        title: "Add Today's Event",
        floatingActionButton: FloatingActionButton(
          onPressed: submit,
          child: const Icon(Icons.save),
        ),
        bottomNavigationBar: QuillToolbar.simple(
          configurations: QuillSimpleToolbarConfigurations(
            controller: _controller,
            multiRowsDisplay: false,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.s8, vertical: Spacing.s16),
          child: ListView(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: getImage,
                  child: const Text('Select Image'),
                ),
              ),
              Center(
                child: widget.lesson != null
                    ? GestureDetector(
                        onTap: () => AppService.viewPicture(
                            CachedNetworkImage(imageUrl: widget.lesson!.imageUrl),
                            "Lesson Image",
                            "lesson_image"),
                        child: Container(
                          height: Spacing.s190,
                          // padding: const EdgeInsets.all(Spacing.s5),
                          margin: const EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: StyleManager.boxDecoration.copyWith(
                            shape: BoxShape.circle,
                          ),
                          child: Hero(
                            tag: "lesson_image",
                            child: CircleAvatar(
                              radius: Spacing.s90,
                              backgroundImage: CachedNetworkImageProvider(widget.lesson!.imageUrl),
                            ),
                          ),
                        ),
                      )
                    : _image == null
                        ? Text(
                            'No image selected.',
                            style: TextStyle(color: ColorManager.deepBblue),
                          )
                        : GestureDetector(
                            onTap: () => AppService.viewPicture(
                                Image.file(_image!), "Lesson Image", "lesson_image"),
                            child: Hero(
                              tag: "lesson_image",
                              child: CircleAvatar(
                                radius: Spacing.s100,
                                backgroundImage: FileImage(_image!),
                              ),
                            ),
                          ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: topicController,
                decoration: const InputDecoration(
                  suffixText: 'Topic',
                  prefixIcon: Icon(
                    Icons.topic,
                    size: Spacing.s28,
                  ),
                ),
                style: TextStyle(color: ColorManager.deepBblue),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a topic';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: subtopicController,
                decoration: const InputDecoration(
                    suffixText: 'Subtopic',
                    prefixIcon: Icon(
                      Icons.topic_outlined,
                      size: Spacing.s28,
                    )),
                style: TextStyle(color: ColorManager.deepBblue),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subtopic';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.s8, vertical: Spacing.s16),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    controller: _controller,
                    autoFocus: true,

                    // readOnly: false,
                    customStyles: DefaultStyles(
                      paragraph: DefaultTextBlockStyle(
                        TextStyle(
                          color: ColorManager.deepBblue,
                          fontSize: 18,
                        ),
                        const VerticalSpacing(1.0, 1),
                        const VerticalSpacing(1.0, 1),
                        const BoxDecoration(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<String> uploadImage() async {
    Reference ref =
        FirebaseStorage.instance.ref().child('events/${DateTime.now().toIso8601String()}.jpg');
    if (_image == null) return '';
    await ref.putFile(_image!);
    return await ref.getDownloadURL();
  }

  void submit() async {
    // AppService.showLoadingPopup(context, "Saving Lesson");
    Lesson? lesson;
    await AppService.showLoadingPopup(
      asyncFunction: () async {
        String? imageUrl;
        if (_image != null) {
          imageUrl = await uploadImage();
        }
        final DateTime now = DateTime.now();

        Lesson newLesson = Lesson(
          id: widget.lesson?.id ?? const Uuid().v4(),
          topic: topicController.text.trim(),
          subtopic: subtopicController.text.trim(),
          body: _controller.document.toDelta().toJson(),
          imageUrl: imageUrl ?? widget.lesson!.imageUrl,
          date: DateTime(now.year, now.month, now.day),
        );
        lesson = newLesson;
        FirebaseFirestore.instance
            .collection('lessons')
            .doc(newLesson.id)
            .set(newLesson.toJson(), SetOptions(merge: true))
            .then(
              (_) async => {
                await AppService.notificationService
                    .sendMessageToTopic(
                        message: newLesson.topic,
                        topic: AppService.lessonTopic,
                        title: "New Lesson")
                    .catchError((err) => err)
              },
            );
      },
      message: "Saving Lesson",
      errorMessage: "Error saving lesson",
      callback: () => Get.offNamed(Routes.lessonDetailRoute, arguments: lesson),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
