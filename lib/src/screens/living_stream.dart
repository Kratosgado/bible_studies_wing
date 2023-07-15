import 'package:flutter/material.dart';

class LivingStream extends StatelessWidget {
  const LivingStream({super.key});

  static const routeName = '/living_stream';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Living Stream'),
      ),
      body: const Center(
        child: Text('Living Stream'),
      ),
    );
  }
}
