import 'package:flutter/material.dart';

class StyleManager {
  static final boxDecoration = BoxDecoration(
    // borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(color: Colors.blue, offset: Offset(0, -1), blurRadius: 5),
      BoxShadow(color: Colors.red, offset: Offset(0, 1), blurRadius: 5),
    ],
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.blue.shade100,
        Colors.blue.shade900,
      ],
    ),
  );
}
