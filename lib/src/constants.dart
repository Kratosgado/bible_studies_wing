import 'package:flutter/material.dart';

const myGradient = LinearGradient(
  colors: [Colors.blue, Colors.red],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const homeGradient = BoxDecoration(
  gradient: LinearGradient(colors: [
    Colors.white54,
    Colors.blue,
    Colors.white54,
    Colors.blue,
    Colors.white54,
  ]),
);
