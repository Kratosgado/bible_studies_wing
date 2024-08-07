import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/comment.sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/lesson.dart';

Widget lessonCard(BuildContext context, Lesson lesson) {
  return SizedBox(
    height: context.height * 0.4,
    width: context.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Spacing.s10),
            child: CachedNetworkImage(
              imageUrl: lesson.imageUrl,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, _, downloadProgress) {
                return Center(
                  child: CircularProgressIndicator(value: downloadProgress.progress),
                );
              },
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppService.formatDate(lesson.date),
              style: context.textTheme.titleSmall
                  ?.copyWith(color: Colors.blueGrey, fontWeight: FontWeight.normal),
            ),
            Text(
              lesson.topic,
              style: context.textTheme.titleSmall?.copyWith(color: Colors.black),
            ),
            Text(
              lesson.subtopic,
              style: context.textTheme.titleSmall
                  ?.copyWith(color: Colors.blueGrey, fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: Spacing.s5,
            ),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.lessonDetailRoute, arguments: lesson),
              child: SizedBox(
                height: context.height * 0.25,
                width: context.width * 0.75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Spacing.s10),
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
            ),
            const SizedBox(
              height: Spacing.s5,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => showCommentSheet(context, lesson),
              icon: const Icon(
                Icons.message_rounded,
                color: Colors.blueAccent,
              ),
              iconSize: 35,
            ),
          ],
        ),
      ],
    ),
  );
}
