import 'package:bible_studies_wing/src/app/notifications.dart';
import 'package:bible_studies_wing/src/screens/home/components/background.image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'src/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await GetStorage.init();

  runApp(const BackgroundImage(child: MyApp()));
}
