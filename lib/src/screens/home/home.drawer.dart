import 'package:bible_studies_wing/src/resources/assets.manager.dart';
import 'package:bible_studies_wing/src/resources/styles_manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Drawer homeDrawer(context) {
  return Drawer(
    elevation: 50,
    shadowColor: Colors.blue,
    child: Container(
      decoration: BoxDecoration(
        gradient: StyleManager.boxDecoration.gradient,
      ),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAssets.background),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.homeRoute),
                    child: const Text(
                      'Bible Studies Wing',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.people,
              color: Colors.black,
            ),
            title: const Text(
              'My People',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () => Get.toNamed(Routes.myPeopleRoute),
          ),
          ListTile(
            leading: const Icon(
              Icons.list_alt_rounded,
              color: Colors.black,
            ),
            title: const Text(
              'Program Outline',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () => Get.toNamed(Routes.programOutlineRoute),
          ),
          ListTile(
            leading: const Icon(
              Icons.water_drop_outlined,
              color: Colors.black,
            ),
            title: const Text(
              'Living Stream Summary',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              Get.toNamed(Routes.livingStreamRoute);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.local_post_office_sharp,
              color: Colors.black,
            ),
            title: const Text(
              'Register a Member',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () => Get.toNamed(Routes.registerRoute),
          ),
          ListTile(
            leading: const Icon(
              Icons.info_rounded,
              color: Colors.black,
            ),
            title: const Text(
              'About Us',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () => Get.toNamed(Routes.aboutUsRoute),
          ),
        ],
      ),
    ),
  );
}
