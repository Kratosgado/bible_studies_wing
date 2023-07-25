import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'lesson.dart';

class LessonDetail extends StatelessWidget {
  final Lesson lesson;

  static const routeName = '/LessonDetail';

  const LessonDetail({super.key, required this.lesson});

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
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
                  )),
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
              quill.QuillEditor(
                expands: false,
                focusNode: FocusNode(),
                scrollController: ScrollController(),
                padding: const EdgeInsets.all(0),
                controller: quill.QuillController(
                  document: quill.Document.fromJson(lesson.body),
                  selection: const TextSelection.collapsed(offset: 0),
                ),
                scrollable: true,
                readOnly: true,
                autoFocus: false,
              ),
              const SizedBox(height: 16),
              Text(
                'Date: ${lesson.date.toLocal().toString()}',
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
