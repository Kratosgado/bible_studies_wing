import 'package:flutter/material.dart';

Drawer homeDrawer() {
  return Drawer(
    // Implement the drawer content here
    child: ListView(
      children: [
        ListTile(
          title: const Text('Screen 1'),
          onTap: () {
            // Handle navigation to Screen 1
          },
        ),
        ListTile(
          title: const Text('Screen 2'),
          onTap: () {
            // Handle navigation to Screen 2
          },
        ),
        // Add more items for other screens
      ],
    ),
  );
}
