import 'dart:io';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
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

class AddLessonScreen extends StatefulWidget {
  const AddLessonScreen({super.key});

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
        child: ListView(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: getImage,
                child: const Text('Select Image'),
              ),
            ),
            Center(
              child: _image == null
                  ? Text(
                      'No image selected.',
                      style: TextStyle(color: ColorManager.deepBblue),
                    )
                  : SizedBox(
                      height: 200,
                      width: context.width,
                      child: Image.file(
                        _image!,
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: topicController,
              decoration: const InputDecoration(labelText: 'Topic'),
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
              decoration: const InputDecoration(labelText: 'Subtopic'),
              style: TextStyle(color: ColorManager.deepBblue),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a subtopic';
                }
                return null;
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.s8, vertical: Spacing.s16),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    controller: _controller,
                    autoFocus: true,
                    readOnly: false,
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
            ),
          ],
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
    String imageUrl = await uploadImage();
    final DateTime now = DateTime.now();

    Lesson newLesson = Lesson(
        id: const Uuid().v4(),
        topic: topicController.text.trim(),
        subtopic: subtopicController.text.trim(),
        body: _controller.document.toDelta().toJson(),
        imageUrl: imageUrl,
        date: DateTime(now.year, now.month, now.day));
    FirebaseFirestore.instance
        .collection('lessons')
        .add(newLesson.toJson())
        .then((value) => Get.offNamed(Routes.lessonDetailRoute, arguments: newLesson));
  }
}
