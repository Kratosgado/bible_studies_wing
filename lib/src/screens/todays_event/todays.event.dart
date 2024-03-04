import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

class TodayEventScreen extends StatelessWidget {
  const TodayEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
      title: "Today's Event",
      floatingActionButton: AppService.currentMember.executive
          ? FloatingActionButton(
              onPressed: () => Get.offNamed(Routes.addtodaysEventRoute),
              child: const Icon(Icons.event),
            )
          : null,
      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('events').orderBy('date', descending: true).limit(1).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text('No events today.',
                    style: TextStyle(fontSize: 20, color: ColorManager.deepBblue)));
          }
          var event = snapshot.data!.docs[0].data();
          final doc = Document.fromJson(event['body']);
          return Column(
            children: [
              CachedNetworkImage(imageUrl: event['image']),
               Text("Date: ${AppService.formatDate(DateTime.parse(event['date']))}"),
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
