import 'package:flutter/material.dart';

class MyPeople extends StatelessWidget {
  const MyPeople({super.key});

  static const routeName = '/my_people';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My People'),
      ),
      body: const Center(
        child: Text('My Peaple'),
      ),
    );
  }
}
