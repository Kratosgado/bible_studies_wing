import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import '../../data/models/lesson.dart';

class LessonDetailScreen extends StatelessWidget {
  final Lesson lesson = Get.arguments;

  LessonDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.topic),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
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
              Text(
                'Subtopic: ${lesson.subtopic}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Anchor Scripture: ${lesson.anchorScripture}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              QuillEditor(
                focusNode: FocusNode(),
                scrollController: ScrollController(),
                configurations: QuillEditorConfigurations(
                  expands: false,
                  padding: const EdgeInsets.all(0),
                  scrollable: true,
                  controller: QuillController(
                    document: Document.fromJson(lesson.body),
                    selection: const TextSelection.collapsed(offset: 0),
                  ),
                  readOnly: true,
                  autoFocus: false,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Date: ${AppService.formatDate(lesson.date)}',
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
