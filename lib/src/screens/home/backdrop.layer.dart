import 'package:bible_studies_wing/src/resources/assets.manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Container backDropLayer() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(ImageAssets.background),
        fit: BoxFit.fill,
      ),
    ),
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
        const ListTile(
          leading: Icon(Icons.picture_in_picture),
          title: Text('Gallery'),
          // TODO: Add gallery route
        ),
        ListTile(
          leading: const Icon(Icons.info_rounded),
          title: const Text('About Us'),
          onTap: () => Get.toNamed(Routes.aboutUsRoute),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () => Get.toNamed(Routes.registerRoute),
        ),
      ],
    ),
  );
}
