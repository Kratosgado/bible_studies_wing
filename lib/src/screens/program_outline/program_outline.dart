import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

class ProgramOutlineScreen extends StatelessWidget {
  const ProgramOutlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
      title: "Program Outline",
      floatingActionButton: AppService.currentMember.executive
          ? FloatingActionButton(
              onPressed: () => Get.offNamed(Routes.addProgramOutlineRoute),
              child: const Icon(Icons.add),
            )
          : null,
      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('program_outline')
            .orderBy('date', descending: true)
            .limit(1)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text('No program today.',
                    style: TextStyle(fontSize: 20, color: ColorManager.deepBblue)));
          }
          var programOutline = snapshot.data?.docs[0].data();
          final doc = Document.fromJson(programOutline?['body']);
          return Column(
            children: [
              // Text("Date: ${AppService.formatDate(DateTime.parse(programOutline?['date']))}"),
              Expanded(
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    controller: QuillController(
                        document: doc, selection: const TextSelection.collapsed(offset: 0)),
                    readOnly: true,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
