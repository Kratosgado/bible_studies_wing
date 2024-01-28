import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/screens/home/home.drawer.dart';
import 'package:bible_studies_wing/src/screens/home/lesson.card.dart'; // Import LessonCard widget
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/lesson.dart'; // Import Lesson model
import '../../data/models/member.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Get auth from firebase
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  // Get member data from firestore
  late final getCurrentUser =
      FirebaseFirestore.instance.collection('members').doc(currentUserUid).get();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getCurrentUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for data, show a loading indicator or some placeholder widget
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // If an error occurred while fetching data, handle it accordingly
            return const Center(
              child: Text('Error fetching data'),
            );
          }
          // Data has been successfully fetched
          final member = Member.fromJson(snapshot.data!.data()!);

          // get last posted lesson from firebase
          // Get lesson from firestore
          final lastPostedLesson = FirebaseFirestore.instance
              .collection('lessons')
              .orderBy('date', descending: true)
              .limit(1)
              .get();
          final streamLessons = FirebaseFirestore.instance
              .collection('lessons')
              .orderBy('date', descending: true)
              .snapshots();

          return Scaffold(
            appBar: AppBar(
              title: const Text('The Word'),
            ),
            drawer: homeDrawer(context),
            body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: streamLessons,
              builder: (context, lessonSnapshot) {
                if (lessonSnapshot.connectionState == ConnectionState.waiting) {
                  // While waiting for lessons data, show a loading indicator or some placeholder widget
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (lessonSnapshot.hasError || !snapshot.hasData) {
                  debugPrint(lessonSnapshot.error.toString());
                  // If an error occurred while fetching lessons data, handle it accordingly
                  return const Center(
                    child: Text('Error fetching lessons data'),
                  );
                } else {
                  // Data has been successfully fetched
                  // final lessons =
                      // lessonSnapshot.data!.docs.map((doc) => Lesson.fromJson(doc.data())).toList();
                  // get first lesson from lessons
                  // final lastPostedLesson = lessons.isNotEmpty ? lessons.first : null;

                  return ListView.builder(
                    itemCount: lessonSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final lesson = Lesson.fromJson(lessonSnapshot.data!.docs[index].data());
                      return lessonCard(
                          context, lesson, member.photoUrl); // Pass the lesson to LessonCard
                    },
                  );
                }
              },
            ),
            floatingActionButton: member.executive
                ? FloatingActionButton(
                    tooltip: 'Create a lesson',
                    onPressed: () => Get.toNamed(Routes.lessonCreatorRoute),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )
                : null,
          );
        });
  }
}

// floatingActionButton: member.executive
//                         ? FloatingActionButton(
//                             onPressed: () => Get.offNamed(Routes.lessonCreatorRoute),
//                             child: const Icon(Icons.add),
//                           )
//                         : null,
