import 'dart:convert';

import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import "package:rxdart/rxdart.dart";

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final _messageStreamController = BehaviorSubject<RemoteMessage>();

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
    await _fcm.subscribeToTopic(AppService.announcementTopic);
    await _fcm.subscribeToTopic(AppService.eventTopic);
    await _fcm.subscribeToTopic(AppService.lessonTopic);
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    debugPrint("Token :: :: $token");
    return token;
  }

  Future<void> sendMessageToTopic(
      {required String message, required String topic, required String title}) async {
    var url =
        Uri.parse("https://fcm.googleapis.com/v1/projects/${AppService.projectId}/messages:send");

    OAuthProvider oAuthProvider = OAuthProvider("");

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AppService.firebaseToken}',
    };
    var body = jsonEncode({
      'message': {
        'topic': topic,
        'notification': {
          'body': message,
          'title': title,
        }
      }
    });

    try {
      var response = await post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        debugPrint("Message sent successfullly to topic: $topic");
      } else {
        debugPrint("Failed to send message. Status code: ${response.statusCode}");
        debugPrint("Response body: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error sending message: $e");
    }
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
