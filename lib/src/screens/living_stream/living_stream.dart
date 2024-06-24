import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:bible_studies_wing/src/screens/home/components/list.tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/lesson.dart';

class LivingStreamScreen extends StatelessWidget {
  const LivingStreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
      title: "Living Stream",
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.s20, horizontal: Spacing.s10),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('lessons')
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error fetching data'),
              );
            }
            final lessonDocs = snapshot.data!.docs;
            if (lessonDocs.isEmpty) {
              return const Center(
                child: Text('No lessons found'),
              );
            }

            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                  // height: 2,
                  ),
              itemCount: lessonDocs.length,
              itemBuilder: (context, index) {
                final lesson = Lesson.fromJson(lessonDocs[index].data());
                return CustomListTile(
                  imageUrl: lesson.imageUrl,
                  title: lesson.topic,
                  subTitle: lesson.subtopic,
                  callback: () => Get.toNamed(Routes.lessonDetailRoute, arguments: lesson),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
