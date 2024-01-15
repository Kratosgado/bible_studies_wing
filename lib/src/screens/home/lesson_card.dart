import 'package:bible_studies_wing/src/screens/home/comments_sheet.dart';
import 'package:bible_studies_wing/src/screens/lesson/lesson_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/models/lesson.dart';

Widget lessonCard(BuildContext context, Lesson lesson, String currentUserProfile) {
  return SizedBox(
    height: 300,
    width: 350,
    child: Card(
        shadowColor: Colors.purple,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => LessonDetail(lesson: lesson))),
              child: SizedBox(
                height: 220,
                width: 350,
                child: CachedNetworkImage(
                  imageUrl: lesson.imageUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(lesson.topic,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => showCommentSheet(context, lesson, currentUserProfile),
                      icon: const Icon(Icons.message_rounded),
                      iconSize: 35,
                    ),
                  ],
                )
              ],
            ),
          ],
        )),
  );
}
