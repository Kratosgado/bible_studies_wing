import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class CurvedScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final FloatingActionButton? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? action;
  final Color? backgroundColor;
  const CurvedScaffold(
      {super.key,
      required this.child,
      required this.title,
      this.floatingActionButton,
      this.action,
      this.bottomNavigationBar, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          action ?? const SizedBox.shrink(),
          TextButton(
            onPressed: () {},
            child: Text(title, style: context.textTheme.titleLarge?.copyWith(color: Colors.white)),
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
