import 'package:bible_studies_wing/src/screens/home/components/background.image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

Future<void> backgroundHandler(RemoteMessage message) async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await Firebase.initializeApp();
  debugPrint('Handling a background message :: :: ${message.messageId}');

  var androidDetails = const AndroidNotificationDetails("channelId", "Channel Name",
      importance: Importance.high, priority: Priority.high);
  var generalNotificationDetails = NotificationDetails(
    android: androidDetails,
  );
  await flutterLocalNotificationsPlugin.show(0, message.notification?.title ?? "BS",
      message.notification?.body ?? "Check it out", generalNotificationDetails);
}
