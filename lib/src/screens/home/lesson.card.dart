import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/screens/home/comment.sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              onTap: () => Get.toNamed(Routes.lessonDetailRoute, arguments: lesson),
              child: SizedBox(
                height: 220,
                width: 350,
                child: Image.network(
                  lesson.imageUrl,
                  // loadingBuilder: (context, _, __) => const CircularProgressIndicator(),
                  // errorBuilder: (context, url, error) => const Icon(Icons.error),
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
