import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const routeName = '/register';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Screen'),
      ),
      body: const Center(
        child: Text('Registration Screen'),
      ),
    );
  }
}
