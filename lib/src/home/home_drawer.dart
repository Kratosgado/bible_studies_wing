import 'package:bible_studies_wing/src/home/home_view.dart';
import 'package:bible_studies_wing/src/screens/program_outline.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/about_us.dart';
import '../screens/living_stream.dart';
import '../screens/my_people.dart';
import '../screens/register.dart';

Drawer homeDrawer(context) {
  return Drawer(
    elevation: 50,
    shadowColor: Colors.blue,
    child: Container(
      decoration: const BoxDecoration(
        gradient: myGradient,
      ),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.restorablePushNamed(context, HomeView.routeName),
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
            onTap: () {
              Navigator.restorablePushNamed(context, MyPeopleScreen.routeName);
            },
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
            onTap: () {
              Navigator.restorablePushNamed(context, ProgramOutlineScreen.routeName);
            },
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
              Navigator.restorablePushNamed(context, LivingStream.routeName);
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
            onTap: () {
              Navigator.restorablePushNamed(context, RegisterScreen.routeName);
            },
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
            onTap: () {
              Navigator.restorablePushNamed(context, AboutUs.routeName);
            },
          ),
        ],
      ),
    ),
  );
}
