import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import '../../data/models/lesson.dart';

class LessonDetailScreen extends StatelessWidget {
  final Lesson lesson = Get.arguments;

  LessonDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
      title: lesson.topic,
      action: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () async => {
          await AppService.showLoadingPopup(
            asyncFunction: () async {
              try {
                await FirebaseFirestore.instance.collection("lessons").doc(lesson.id).delete();
                await FirebaseStorage.instance.refFromURL(lesson.imageUrl).delete();
              } catch (e) {
                rethrow;
              }
            },
            message: "Deleting Lesson",
            errorMessage: "Error Deleting message",
            callback: () => Get.back(),
          )
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.offNamed(Routes.lessonCreatorRoute, arguments: lesson),
        child: const Icon(Icons.edit),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Spacing.s28),
                  child: CachedNetworkImage(
                    imageUrl: lesson.imageUrl,
                    progressIndicatorBuilder: (context, _, downloadProgress) {
                      return Center(
                        child: CircularProgressIndicator(value: downloadProgress.progress),
                      );
                    },
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: Spacing.s16),
              QuillEditor(
                focusNode: FocusNode(),
                controller: QuillController(
                  document: Document.fromJson(lesson.body),
                  selection: const TextSelection.collapsed(offset: 0),
                  readOnly: true,
                ),
                scrollController: ScrollController(),
                config: QuillEditorConfig(
                  expands: false,
                  padding: const EdgeInsets.all(0),
                  scrollable: true,
                  // readOnly: true,
                  autoFocus: false,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Date: ${AppService.formatDate(lesson.date)}',
                style: context.textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
