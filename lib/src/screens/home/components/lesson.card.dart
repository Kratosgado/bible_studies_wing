import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/comment.sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/lesson.dart';

Widget lessonCard(BuildContext context, Lesson lesson, String currentUserProfile) {
  return SizedBox(
    height: 300,
    width: 350,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(Routes.lessonDetailRoute, arguments: lesson),
          child: SizedBox(
            height: 220,
            width: 350,
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
    ),
  );
}
