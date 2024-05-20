import 'package:bible_studies_wing/src/resources/assets.manager.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;
  const BackgroundImage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage(ImageAssets.background),
        fit: BoxFit.cover,
      )),
      child: child,
    );
  }
}
