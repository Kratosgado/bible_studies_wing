import 'dart:io';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/material.dart';

import '../../data/models/lesson.dart';

class LessonCreatorScreen extends StatefulWidget {
  const LessonCreatorScreen({super.key});

  @override
  LessonCreatorScreenState createState() => LessonCreatorScreenState();
}

class LessonCreatorScreenState extends State<LessonCreatorScreen> {
  final formKey = GlobalKey<FormState>();
  final topicController = TextEditingController();
  final subtopicController = TextEditingController();
  final anchorScriptureController = TextEditingController();
  final versesController = TextEditingController();

  late QuillController bodyController;
  // get current member from firebase
  final auth = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    bodyController = QuillController.basic();
  }

  File? imageFile;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Lesson'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: imageFile != null
                      ? Image.file(
                          imageFile!,
                          height: 200,
                          width: 200,
                        )
                      : const SizedBox.shrink(),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: pickImage,
                    child: const Text('Select Flyer'),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: topicController,
                  decoration: const InputDecoration(labelText: 'Topic'),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subtopic';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: anchorScriptureController,
                  decoration:
                      const InputDecoration(labelText: 'Anchor Scripture'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the anchor scripture';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: versesController,
                  decoration: const InputDecoration(labelText: 'Verses'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the verses';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Body'),
                QuillToolbar.simple(
                  configurations: QuillSimpleToolbarConfigurations(
                      controller: bodyController),
                ),
                SizedBox(
                  height: 300,
                  child: QuillEditor.basic(
                    configurations: QuillEditorConfigurations(
                        controller: bodyController, readOnly: true),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: saveLesson,
        icon: const Icon(Icons.upload),
        label: const Text('Upload Lesson'),
      ),
    );
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> saveLesson() async {
    if (formKey.currentState!.validate()) {
      final firestore = FirebaseFirestore.instance;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('lesson_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      final UploadTask uploadTask = storageRef.putFile(imageFile!);
      final TaskSnapshot storageSnapshot = await uploadTask;
      imageUrl = await storageSnapshot.ref.getDownloadURL();
      const uuid = Uuid();
      final DateTime now = DateTime.now();
      final newLesson = Lesson(
        id: uuid.v4(),
        topic: topicController.text,
        subtopic: subtopicController.text,
        anchorScripture: anchorScriptureController.text,
        verses: versesController.text
            .split(',')
            .map((verse) => verse.trim())
            .toList(),
        body: bodyController.document.toDelta().toJson(),
        imageUrl: imageUrl!,
        date: DateTime(now.year, now.month, now.day),
      );


      await firestore.collection('lessons').add(newLesson.toJson()).then((_) => Get.toNamed(Routes.lessonDetailRoute, arguments: newLesson));
    }
  }
}
