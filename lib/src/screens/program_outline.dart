import 'package:flutter/material.dart';

class ProgramOutlineScreen extends StatelessWidget {
  const ProgramOutlineScreen({super.key});

  static const routeName = '/program_outline';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Program Outline'),
      ),
      body: const Center(
        child: Text('Program Outline'),
      ),
    );
  }
}
