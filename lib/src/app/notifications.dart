import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialize() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Got a message whilst in the foreground");
      debugPrint("Message data: ${message.data}");

      if (message.notification != null) {
        debugPrint("Message also contained a notification: ${message.notification}");
      }
    });

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // get the token
    await getToken();
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    debugPrint("Token: $token");
    return token;
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message ${message.messageId}");
}
