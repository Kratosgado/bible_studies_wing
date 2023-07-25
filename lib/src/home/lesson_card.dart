import 'package:bible_studies_wing/src/home/comments_sheet.dart';
import 'package:bible_studies_wing/src/lesson/lesson_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../lesson/lesson.dart';

Widget lessonCard(BuildContext context, Lesson lesson) {
  void shareLesson(Lesson lesson) {
    Share.share(
        'Check out this lesson on ${lesson.topic} at ${lesson.imageUrl} \n\nShared via Bible Studies Wing');
  }

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
                      onPressed: () => shareLesson(lesson),
                      icon: const Icon(Icons.share),
                      iconSize: 35,
                    ),
                    IconButton(
                      onPressed: () => showCommentSheet(context),
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
