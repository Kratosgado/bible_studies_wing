import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
      title: "Announcement",
      floatingActionButton: AppService.currentMember.executive
          ? FloatingActionButton(
              onPressed: () => Get.offNamed(Routes.addAnnouncementRoute),
              child: const Icon(Icons.announcement),
            )
          : null,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('announcement').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text('No announcement today.',
                    style: TextStyle(fontSize: 20, color: ColorManager.deepBblue)));
          }
          var announcement = snapshot.data?.docs[0];
          final doc = Document.fromJson(announcement?['body']);
          return Column(
            children: [
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
