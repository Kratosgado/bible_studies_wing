import 'package:bible_studies_wing/src/resources/assets.manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/backdrop.layer.dart';
import 'package:bible_studies_wing/src/screens/home/front.layer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

          return Container(
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAssets.background),
                fit: BoxFit.fill,
              ),
            ),
            child: BackdropScaffold(
              appBar: BackdropAppBar(
                toolbarHeight: Spacing.s90,
                backgroundColor: Colors.transparent,
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: Text('The Word', style: Theme.of(context).textTheme.titleLarge),
                  )
                ],
              ),
              stickyFrontLayer: true,
              backgroundColor: Colors.transparent,
              frontLayerBackgroundColor: Colors.white,

              backLayer: backDropLayer(),
              frontLayer: frontLayer(context, member.photoUrl),
              // bottomNavigationBar: BottomNavigationBar(),
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
            ),
          );
        });
  }
}
