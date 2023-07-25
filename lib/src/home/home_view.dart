import 'package:bible_studies_wing/src/home/home_drawer.dart';
import 'package:bible_studies_wing/src/home/lesson_card.dart'; // Import LessonCard widget
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../lesson/lesson_creator.dart';
import '../lesson/lesson.dart'; // Import Lesson model
import '../member/member.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  // Get auth from firebase
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  // Get member data from firestore
  late final memberData =
      FirebaseFirestore.instance.collection('members').doc(currentUserUid).get();

  // Get lessons from firestore
  final lessonsCollection = FirebaseFirestore.instance.collection('lessons');

  // Create a member object from the data
  static const routeName = "/HomeView";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: memberData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for data, show a loading indicator or some placeholder widget
          return Scaffold(
            appBar: AppBar(
              title: const Text('The Word'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // If an error occurred while fetching data, handle it accordingly
          return Scaffold(
            appBar: AppBar(
              title: const Text('The Word'),
            ),
            body: const Center(
              child: Text('Error fetching data'),
            ),
          );
        } else {
          // Data has been successfully fetched
          final member = Member.fromMap(currentUserUid, snapshot.data!.data()!);

          // Get today's date and yesterday's date
          final DateTime now = DateTime.now();
          final DateTime today = DateTime(now.year, now.month, now.day);
          final DateTime yesterday = today.subtract(const Duration(days: 1));

          // Query lessons for today and yesterday
          final todayAndYesterdayLessons = lessonsCollection
              .where('date', isGreaterThanOrEqualTo: yesterday, isLessThanOrEqualTo: today)
              .get();

          return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: todayAndYesterdayLessons,
            builder: (context, lessonSnapshot) {
              if (lessonSnapshot.connectionState == ConnectionState.waiting) {
                // While waiting for lessons data, show a loading indicator or some placeholder widget
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('The Word'),
                  ),
                  drawer: homeDrawer(context),
                  body: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  floatingActionButton: member.executive
                      ? FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(LessonCreator.routeName);
                          },
                          child: const Icon(Icons.add),
                        )
                      : null,
                );
              } else if (lessonSnapshot.hasError || !snapshot.hasData) {
                debugPrint(lessonSnapshot.error.toString());
                // If an error occurred while fetching lessons data, handle it accordingly
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('The Word'),
                  ),
                  drawer: homeDrawer(context),
                  body: const Center(
                    child: Text('Error fetching lessons data'),
                  ),
                  floatingActionButton: member.executive
                      ? FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(LessonCreator.routeName);
                          },
                          child: const Icon(Icons.add),
                        )
                      : null,
                );
              } else {
                // Data has been successfully fetched
                final lessons = lessonSnapshot.data!.docs
                    .map((doc) => Lesson.fromMap(doc.id, doc.data()))
                    .toList();

                // Filter the lessons to get the one made today or yesterday
                Lesson? lessonTodayOrYesterday;
                for (final lesson in lessons) {
                  if (lesson.date.isAfter(yesterday) &&
                      lesson.date.isBefore(today.add(const Duration(days: 1)))) {
                    lessonTodayOrYesterday = lesson;
                    break;
                  }
                }

                return Scaffold(
                  appBar: AppBar(
                    title: const Text('The Word'),
                  ),
                  drawer: homeDrawer(context),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      lessonTodayOrYesterday != null
                          ? lessonCard(
                              context, lessonTodayOrYesterday) // Pass the lesson to LessonCard
                          : const Text('No lesson for today or yesterday'),
                      const SizedBox(
                        height: 200,
                      )
                    ],
                  ),
                  floatingActionButton: member.executive
                      ? FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(LessonCreator.routeName);
                          },
                          child: const Icon(Icons.add),
                        )
                      : null,
                );
              }
            },
          );
        }
      },
    );
  }
}
