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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/add_lesson');
          },
          child: const Icon(Icons.add),
        ),
        child: const Center(
          child: Text('Program Outline'),
        ));
  }
}
