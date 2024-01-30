import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';

class ProgramOutlineScreen extends StatelessWidget {
  const ProgramOutlineScreen({super.key});

  static const routeName = '/program_outline';

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      appBar: BackdropAppBar(
        title: const Text('Program Outline'),
      ),
      backLayer: const SizedBox(),
      frontLayer: const Center(
        child: Text('Program Outline'),
      ),
    );
  }
}
