import 'package:flutter/material.dart';

import '../constants.dart';

Drawer homeDrawer() {
  return Drawer(
    elevation: 50,
    shadowColor: Colors.blue,
    child: Container(
      decoration: const BoxDecoration(
        gradient: myGradient,
      ),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.transparent, // Transparent background for the header
            ),
            child: Center(
              child: Text(
                'Bible Studies Wing',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.people,
              color: Colors.white,
            ),
            title: const Text(
              'My People',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              // Handle navigation to Screen 1
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.list_alt_rounded,
              color: Colors.white,
            ),
            title: const Text(
              'Program Outline',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              // Handle navigation to Screen 2
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.water_drop_outlined,
              color: Colors.white,
            ),
            title: const Text(
              'Living Stream Summary',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              // Handle navigation to Screen 2
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.local_post_office_sharp,
              color: Colors.white,
            ),
            title: const Text(
              'Register a Member',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              // Handle navigation to Screen 2
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info_rounded,
              color: Colors.white,
            ),
            title: const Text(
              'About Us',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              // Handle navigation to Screen 2
            },
          ),
        ],
      ),
    ),
  );
}
