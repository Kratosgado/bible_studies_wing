import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:flutter/material.dart';

class StyleManager {
  static final boxDecoration = BoxDecoration(
    // borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(color: Colors.black, offset: Offset(0, -1), blurRadius: 5),
      BoxShadow(color: Colors.black54, offset: Offset(0, 1), blurRadius: 5),
    ],
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white,
        ColorManager.faintWhite,
      ],
    ),
  );
}
