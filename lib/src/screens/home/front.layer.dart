import 'package:bible_studies_wing/src/data/models/lesson.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/lesson.card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget frontLayer(BuildContext context, String currentUserPhotoUrl) {
  // get last posted lesson from firebase
  // Get lesson from firestore
  final retrieveLessons = FirebaseFirestore.instance
      .collection('lessons')
      .orderBy('date', descending: true)
      .snapshots();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: Spacing.s16),
    child: StreamBuilder(
        stream: retrieveLessons,
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
          try {
            final lessonsDocs = snapShot.data!.docs;
            return ListView.separated(
              separatorBuilder: (_, __) => Divider(
                color: ColorManager.faintWhite,
                thickness: 5.0,
              ),
              itemCount: lessonsDocs.length,
              itemBuilder: (ctx, index) {
                final lesson = Lesson.fromJson(lessonsDocs[index].data());
                return lessonCard(context, lesson);
              },
            );
          } catch (e) {
            return const Center(
              child: Text('Error fetching data'),
            );
          }
        }),
  );
}
