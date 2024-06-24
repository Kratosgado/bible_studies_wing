import 'package:bible_studies_wing/src/resources/string_manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  static const routeName = '/about_us';

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
      title: "About Us",
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.s16, vertical: Spacing.s20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AboutUs.aboutHeading,
                textAlign: TextAlign.center,
                softWrap: true,
                style: context.textTheme.titleLarge,
              ),
              const SizedBox(
                height: Spacing.s20,
              ),
              Text.rich(
                TextSpan(
                  text: AboutUs.aboutUs,
                  style: context.textTheme.bodyMedium,
                  children: [
                    TextSpan(text: AboutUs.missionTitle, style: context.textTheme.titleMedium),
                    TextSpan(text: AboutUs.missionText, style: context.textTheme.bodyMedium),
                    TextSpan(text: AboutUs.purposeTitle, style: context.textTheme.titleMedium),
                    TextSpan(text: AboutUs.purposeText, style: context.textTheme.bodyMedium),
                    TextSpan(text: AboutUs.call, style: context.textTheme.titleMedium),
                    TextSpan(text: AboutUs.callvalue, style: context.textTheme.bodyMedium),
                    TextSpan(text: AboutUs.response, style: context.textTheme.titleMedium),
                    TextSpan(text: AboutUs.responseValue, style: context.textTheme.bodyMedium),
                    TextSpan(text: AboutUs.bibleRef, style: context.textTheme.titleMedium),
                    TextSpan(text: AboutUs.bibleRefValue, style: context.textTheme.bodyMedium),
                  ],
                ),
              ),
              Text(
                AboutUs.godBless,
                style: context.textTheme.displayMedium?.copyWith(color: Colors.black),
              ),
              // const SizedBox(
              //   height: Spacing.s250,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
