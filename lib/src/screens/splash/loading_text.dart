import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:flutter/material.dart';

class LoadingText extends StatelessWidget {
  const LoadingText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Spacing.s20 * 5,
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 2),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) => Column(
          children: [
            LinearProgressIndicator(
              color: Colors.deepPurpleAccent,
              backgroundColor: Colors.black,
              value: value,
            ),
            const SizedBox(
              height: Spacing.s20 / 2,
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, shadows: [
                Shadow(color: Colors.pink, blurRadius: 10, offset: Offset(2, 2)),
                Shadow(color: Colors.blue, blurRadius: 10, offset: Offset(-2, -2)),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
