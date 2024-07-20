import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/backdrop.layer.dart';
import 'package:bible_studies_wing/src/screens/home/front.layer.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Get auth from firebase

  @override
  Widget build(BuildContext context) {
    final currentMember = AppService.currentMember!;
    return BackdropScaffold(
      appBar: BackdropAppBar(
        toolbarHeight: Spacing.s90,
        backgroundColor: Colors.transparent,
        title: Text('The Word our light our sword', style: context.textTheme.titleSmall),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.todaysEventRoute), icon: const Icon(Icons.event)),
          Badge(
            // offset: const Offset(4, 3),
            alignment: Alignment.center,
            child: IconButton(
                onPressed: () => Get.toNamed(Routes.announcementRoute),
                icon: const Icon(Icons.notification_add)),
          ),
        ],
      ),
      stickyFrontLayer: true,
      backgroundColor: Colors.transparent,
      frontLayerBackgroundColor: Colors.white,

      backLayer: backDropLayer(),
      frontLayer: frontLayer(context, currentMember.photoUrl),
      // bottomNavigationBar: BottomNavigationBar(),
      floatingActionButton: currentMember.executivePosition != null
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
  }
}
