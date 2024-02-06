import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/background.image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bible_studies_wing/src/functions.dart' show handleSignout;

BackgroundImage backDropLayer() {
  return BackgroundImage(
    child: ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text('My People'),
          onTap: () => Get.toNamed(Routes.myPeopleRoute),
        ),
        ListTile(
          leading: const Icon(Icons.list_alt_rounded),
          title: const Text('Program Outline'),
          onTap: () => Get.toNamed(Routes.programOutlineRoute),
        ),
        ListTile(
          leading: const Icon(Icons.water_drop_outlined),
          title: const Text('Living Stream Summary'),
          onTap: () {
            Get.toNamed(Routes.livingStreamRoute);
          },
        ),
        ListTile(
          leading: const Icon(Icons.local_post_office_sharp),
          title: const Text('Register a Member'),
          onTap: () => Get.toNamed(Routes.registerRoute),
        ),
        ListTile(
          leading: const Icon(Icons.picture_in_picture),
          title: const Text('Gallery'),
          onTap: () => Get.toNamed(Routes.galleryRoute),
        ),
        ListTile(
          leading: const Icon(Icons.info_rounded),
          title: const Text('About Us'),
          onTap: () => Get.toNamed(Routes.aboutUsRoute),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () async => await handleSignout(),
        ),
      ],
    ),
  );
}
