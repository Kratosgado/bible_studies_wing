import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
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
      floatingActionButton: AppService.currentMember!.executivePosition != null
          ? FloatingActionButton(
              onPressed: () => Get.offNamed(Routes.addtodaysEventRoute),
              child: const Icon(Icons.event),
            )
          : null,
      child: FutureBuilder(
        future: FirebaseFirestore.instance.collection('once').doc("event").get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if (!snapshot.data!.exists) {
            return Center(
                child: Text('No event today.',
                    style: TextStyle(fontSize: 20, color: ColorManager.deepBblue)));
          }
          var event = snapshot.data!.data()!;
          final doc = Document.fromJson(event['body']);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.s8, vertical: Spacing.s16),
              child: Column(
                children: [
                  Text(
                    "Date: ${AppService.formatDate(
                      DateTime.parse(
                        event['date'],
                      ),
                    )}",
                    style: Theme.of(context).primaryTextTheme.bodyLarge,
                  ),
                  Divider(
                    thickness: 1,
                    color: ColorManager.deepBblue,
                  ),
                  CachedNetworkImage(
                    imageUrl: event['image'],
                    progressIndicatorBuilder: (context, _, downloadProgress) {
                      return Center(
                        child: CircularProgressIndicator(value: downloadProgress.progress),
                      );
                    },
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                  QuillEditor.basic(
                    configurations: QuillEditorConfigurations(
                      controller: QuillController(
                        document: doc,
                        selection: const TextSelection.collapsed(offset: 0),
                      ),
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
                      // readOnly: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
