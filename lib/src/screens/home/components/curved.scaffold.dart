import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.clip.dart';
import 'package:flutter/material.dart';

class CurvedScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  const CurvedScaffold({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
        height: Spacing.s90,
        title: title,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: child,
      ),
    );
  }
}
