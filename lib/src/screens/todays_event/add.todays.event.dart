import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'dart:io';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  AddEventScreenState createState() => AddEventScreenState();
}

class AddEventScreenState extends State<AddEventScreen> {
  final QuillController _controller = QuillController.basic();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
      title: 'Add Event',
      child: Column(
        children: [
          ElevatedButton(
            onPressed: getImage,
            child: const Text('Select Image'),
          ),
          _image == null
              ? Text(
                  'No image selected.',
                  style: TextStyle(color: ColorManager.deepBblue),
                )
              : Image.file(_image!),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                  controller: _controller,
                  paintCursorAboveText: true,
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
          ElevatedButton(
            onPressed: submit,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
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
    FirebaseFirestore.instance.collection('events').add({
      'date': DateTime.now().toString(),
      'image': imageUrl,
      'body': _controller.document.toDelta().toJson(),
    }).then((value) => Get.offNamed(Routes.todaysEventRoute));
  }
}
