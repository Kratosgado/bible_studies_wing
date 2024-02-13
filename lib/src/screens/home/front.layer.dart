import 'package:bible_studies_wing/src/data/models/lesson.dart';
import 'package:bible_studies_wing/src/resources/assets.manager.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/lesson.card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget frontLayer(BuildContext context, String currentUserPhotoUrl) {
  // get last posted lesson from firebase
  // Get lesson from firestore
  final lastPostedLesson = FirebaseFirestore.instance
      .collection('lessons')
      .orderBy('date', descending: true)
      .limit(1)
      .get();
  return Padding(
    padding: const EdgeInsets.all(Spacing.s16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: Spacing.s12,
        ),
        Text(
          "Today's Living Stream",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: ColorManager.deepBblue, fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.faintWhite,
            borderRadius: BorderRadius.circular(Spacing.s16),
          ),
          margin: const EdgeInsets.symmetric(vertical: Spacing.s16),
          width: Get.width,
          height: Get.height * 0.4,
          child: FutureBuilder(
              future: lastPostedLesson,
              builder: (_, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting || !snapShot.hasData) {
                  // While waiting for data, show a loading indicator or some placeholder widget
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapShot.hasError) {
                  // If an error occurred while fetching data, handle it accordingly
                  return const Center(
                    child: Text('Error fetching data'),
                  );
                }
                // Data has been successfully fetched
                final lesson = Lesson.fromJson(snapShot.data!.docs[0].data());
                return lessonCard(context, lesson, currentUserPhotoUrl);
              }),
        ),
        const SizedBox(
          height: Spacing.s16,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Today's Event",
              style: TextStyle(
                fontSize: Spacing.s20,
                fontWeight: FontWeight.bold,
                color: ColorManager.darkColor,
              ),
            ),
            Text(
              "Announcement",
              style: TextStyle(
                fontSize: Spacing.s20,
                fontWeight: FontWeight.bold,
                color: ColorManager.darkColor,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkResponse(
              onTap: () {
                Get.toNamed(Routes.todaysEventRoute);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.faintWhite,
                  borderRadius: BorderRadius.circular(Spacing.s16),
                ),
                width: Get.width * 0.4 + Spacing.s16,
                height: Get.height * 0.25,
                child: Center(
                  child: ImageIcon(
                    const AssetImage(
                      IconAssets.meeting,
                    ),
                    color: ColorManager.deepBblue,
                    size: Spacing.s100,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorManager.faintWhite,
                borderRadius: BorderRadius.circular(Spacing.s16),
              ),
              width: Get.width * 0.4 + Spacing.s16,
              height: Get.height * 0.25,
              child: Center(
                child: ImageIcon(
                  const AssetImage(
                    IconAssets.megaphone,
                  ),
                  color: ColorManager.deepBblue,
                  size: Spacing.s100,
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
