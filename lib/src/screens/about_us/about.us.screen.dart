import 'package:bible_studies_wing/src/resources/string_manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  static const routeName = '/about_us';

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
      title: "About Us",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.s16, vertical: Spacing.s20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AboutUs.aboutHeading,
              textAlign: TextAlign.center,
              softWrap: true,
              style: Theme.of(context).primaryTextTheme.bodyLarge,
            ),
            const SizedBox(
              height: Spacing.s20,
            ),
            Text.rich(
              TextSpan(
                text: AboutUs.aboutUs,
                style: Theme.of(context).primaryTextTheme.bodyMedium,
                children: const [
                  TextSpan(text: AboutUs.call, style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: AboutUs.callvalue),
                  TextSpan(text: AboutUs.response, style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: AboutUs.responseValue),
                  TextSpan(text: AboutUs.bibleRef, style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: AboutUs.bibleRefValue),
                ],
              ),
            ),
            Text(
              AboutUs.godBless,
              style: Theme.of(context).primaryTextTheme.bodyLarge,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
