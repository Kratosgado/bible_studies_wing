import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../lesson/lesson_detail.dart';
import '../../data/models/lesson.dart';

class LivingStreamScreen extends StatelessWidget {
  const LivingStreamScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Living Stream'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
          } else {
            final lessonDocs = snapshot.data!.docs;
            if (lessonDocs.isEmpty) {
              return const Center(
                child: Text('No lessons found'),
              );
            }

            return ListView.builder(
              itemCount: lessonDocs.length,
              itemBuilder: (context, index) {
                final lessonData = lessonDocs[index].data();
                final lesson = Lesson.fromJson(lessonData);
                return ListTile(
                  title: Text(lessonData['topic']),
                  subtitle: Text(lessonData['subtopic']),
                  onTap: () => Get.toNamed(Routes.lessonDetailRoute, arguments: lesson),
                );
              },
            );
          }
        },
      ),
    );
  }
}
