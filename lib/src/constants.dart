import 'package:flutter/material.dart';

const myGradient = LinearGradient(
  colors: [Colors.red, Colors.blue],
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
