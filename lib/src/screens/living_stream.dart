import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../lesson/lesson_detail.dart';
import '../lesson/lesson.dart';

class LivingStream extends StatelessWidget {
  const LivingStream({super.key});

  static const routeName = '/living_stream';

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
                final lesson = Lesson.fromMap(lessonData['id'], lessonData);
                return ListTile(
                  title: Text(lessonData['topic']),
                  subtitle: Text(lessonData['subtopic']),
                  onTap: () {
                    // Navigate to the lesson detail screen when tapped
                    // Replace `LessonDetailScreen` with the appropriate screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonDetail(lesson: lesson),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
