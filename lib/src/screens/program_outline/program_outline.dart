
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgramOutlineScreen extends StatelessWidget {
  const ProgramOutlineScreen({super.key});

  static const routeName = '/program_outline';

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
      title: "Program Outline",
      child: Container(
        height: context.height,
        width: context.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: const Center(child: Text('Program Outline')),
      ),
    );
  }
}
