import 'dart:async';

import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'animated_container.dart';
import 'loading_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashScreen> {
  Timer? timer;

  startDelay() {
    timer = Timer(const Duration(seconds: 2), goNext);
  }

  goNext() async {
    AppService.preferences.isUserLoggedIn().then((value) async => {
          if (value)
            {await Get.put(AppService()).init(), Get.offNamed(Routes.homeRoute)}
          else
            {Get.offNamed(Routes.registerRoute)}
        });
  }

  @override
  void initState() {
    super.initState();
    startDelay();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedImageContainer(width: 100, height: 100),
            SizedBox(height: Spacing.s20),
            LoadingText(),
          ],
        ),
      ),
    );
  }
}
