import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  static const routeName = '/about_us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Center(
        child: Text('About Us'),
      ),
    );
  }
}
