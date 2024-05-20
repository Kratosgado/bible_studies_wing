import 'dart:async';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:flutter/services.dart';

import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

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
    AppService.preferences.isUserLoggedIn().then((value) async {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.manageExternalStorage,
        Permission.mediaLibrary,
        Permission.photos,
      ].request();

      if (statuses[Permission.storage] != PermissionStatus.granted) {
        await Permission.storage.request();
      }
      if (statuses[Permission.manageExternalStorage] != PermissionStatus.granted) {
        await Permission.manageExternalStorage.request();
      }
      if (statuses[Permission.mediaLibrary] != PermissionStatus.granted) {
        await Permission.mediaLibrary.request();
      }
      if (statuses[Permission.photos] != PermissionStatus.granted) {
        await Permission.photos.request();
      }
      if (value) {
        await Get.put(AppService()).init().then((_) async => await Get.offNamed(Routes.homeRoute));
      } else {
        Get.offNamed(Routes.registerRoute);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
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
