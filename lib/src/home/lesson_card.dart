import 'package:bible_studies_wing/src/home/comments_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../lesson/lesson.dart';

Widget lessonCard(BuildContext context, Lesson lesson) {
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
            SizedBox(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(lesson.topic,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
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
