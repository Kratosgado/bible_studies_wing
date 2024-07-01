import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import "package:rxdart/rxdart.dart";
// import 'package:flutter/material.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final _messageStreamController = BehaviorSubject<RemoteMessage>();

  static const String lessonTopic = "lesson";
  static const String eventTopic = "event";
  static const String announcementTopic = "announcement";

  Future initialize() async {
    final settings = await _fcm.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    _fcm.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    if (kDebugMode) {
      print("Permission granted: ${settings.authorizationStatus}");
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Got a message whilst in the foreground");
      debugPrint("Message data: ${message.data}");

      if (message.notification != null) {
        debugPrint("Message also contained a notification: ${message.notification}");
      }

      _messageStreamController.sink.add(message);
    });

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // get the token
    await getToken();
    // subscribe to topic
    await _fcm.subscribeToTopic(lessonTopic);
    await _fcm.subscribeToTopic(eventTopic);
    await _fcm.subscribeToTopic(announcementTopic);
    await _fcm.getInitialMessage();
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    debugPrint("Token :: :: $token");
    return token;
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('Handling a background message: ${message.messageId}');
    print('message data: ${message.data}');
    print('message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}
