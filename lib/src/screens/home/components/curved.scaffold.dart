import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class CurvedScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final FloatingActionButton? floatingActionButton;
  final Widget? bottomNavigationBar;
  const CurvedScaffold(
      {super.key,
      required this.child,
      required this.title,
      this.floatingActionButton,
      this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(title, style: context.textTheme.displaySmall),
          )
        ],
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
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: false,
    );
  }
}
