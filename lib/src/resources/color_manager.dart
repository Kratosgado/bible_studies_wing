import 'package:flutter/material.dart';

class ColorManager {
  static const secondaryColor = Color(0xFF242430);
  static const darkColor = Color(0xFF191923);
  static const bgColor = Color(0xFF000515);
  static final Color topColor = Colors.blue.shade700;
  static final Color bottomColor = Colors.teal.shade400;

  static final deepBblue = HexColor.fromHex('#1f2544');
  static final mediumBlue = HexColor.fromHex('#0c2d57');
  static final faintWhite = HexColor.fromHex('#dbe3ed');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return  Color(int.parse(hexColorString, radix: 16));
  }
}
