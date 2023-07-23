import 'package:bible_studies_wing/src/home/home_drawer.dart';
import 'package:bible_studies_wing/src/home/verse_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../lesson/lesson_creator.dart';
import '../member/member.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  // Get auth from firebase
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  // Get member data from firestore
  late final memberData =
      FirebaseFirestore.instance.collection('members').doc(currentUserUid).get();

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
          return Scaffold(
            appBar: AppBar(
              title: const Text('The Word'),
            ),
            drawer: homeDrawer(context),
            body: Center(
              child: verseCard(context),
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
}
