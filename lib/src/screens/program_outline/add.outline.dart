import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart';

class AddProgramOutlineScreen extends StatelessWidget {
  final QuillController _controller = QuillController.basic();

  AddProgramOutlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
      title: 'Add Program Outline',
      floatingActionButton: FloatingActionButton(
        onPressed: uploadAnnouncement,
        child: const Icon(Icons.upload),
      ),
      child: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.s8, vertical: Spacing.s16),
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
      ]),
    );
  }

  void uploadAnnouncement() async {
    FirebaseFirestore.instance.collection('program_outline').add({
      'date': DateTime.now().toString(),
      'body': _controller.document.toDelta().toJson,
    }).then((value) => Get.offNamed(Routes.programOutlineRoute));
  }
}
