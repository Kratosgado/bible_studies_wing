import 'dart:convert';

import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import "package:rxdart/rxdart.dart";

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final _messageStreamController = BehaviorSubject<RemoteMessage>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initialize() async {
    const androidInitSettings = AndroidInitializationSettings("@mipmap/launcher_icon");
    const iosInitSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        debugPrint("local:: :: ${details.id}");
      },
      onDidReceiveBackgroundNotificationResponse: backgroundNotificationHandler,
    );
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
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint("Got a message whilst in the foreground");
      debugPrint("Message data:: :: ${message.data}");

      if (message.notification != null) {
        debugPrint("Message also contained a notification: ${message.notification}");
      }
      await showLocalNotification(
          id: message.messageId.hashCode,
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: message.data.toString());

      _messageStreamController.sink.add(message);
    });

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

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
    final client = http.Client();

    try {
      final serviceAccountKey = await rootBundle.loadString("assets/config/serviceAccountKey.json");
      final accountJson = jsonDecode(serviceAccountKey);

      final credentials = ServiceAccountCredentials.fromJson(accountJson);
      var url = Uri.parse(
          "https://fcm.googleapis.com/v1/projects/${accountJson["project_id"]}/messages:send");
      final scopes = ["https://www.googleapis.com/auth/firebase.messaging"];
      final accessCredentials =
          await obtainAccessCredentialsViaServiceAccount(credentials, scopes, client);
      final authClient =
          authenticatedClient(client, accessCredentials, closeUnderlyingClient: true);

      var body = jsonEncode({
        'message': {
          'topic': topic,
          'notification': {
            'body': message,
            'title': title,
          }
        }
      });
      var response = await authClient.post(url, body: body);
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

  Future<void> backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    updateBadge(await _messageStreamController.length);
    if (kDebugMode) {
      print('Handling a background message :: :: ${message.messageId}');
    }
    var androidDetails = const AndroidNotificationDetails("channelId", "Channel Name",
        importance: Importance.high, priority: Priority.high);
    var generalNotificationDetails = NotificationDetails(
      android: androidDetails,
    );
    await flutterLocalNotificationsPlugin.show(0, message.notification?.title ?? "BS",
        message.notification?.body ?? "Check it out", generalNotificationDetails);
  }

  static void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    debugPrint('id :: :: $id');
  }

  static void backgroundNotificationHandler(NotificationResponse details) {
    debugPrint("Background notification :: ${details.id}");
  }

  void selectNotification(RemoteMessage? message) {
    if (message != null && message.notification != null) {
      _messageStreamController.sink.add(message);
    }
  }

  Future<NotificationDetails> _notificationDetails() async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "channel id",
      "channel name",
      groupKey: 'com.example.bible_studies_wing',
      channelDescription: "Bible lessons channel",
      importance: Importance.max,
      playSound: true,
      priority: Priority.max,
      ticker: 'ticker',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
    );
    const iosNotificationDetails = DarwinNotificationDetails(
      threadIdentifier: "thread1",
    );

    // final details = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    // if (details != null && details.didNotificationLaunchApp) {
    //   behaviorSubject.add(details.notificationResponse!.payload!);
    // }
    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosNotificationDetails,
    );
    return platformChannelSpecifics;
  }

  Future<void> showLocalNotification(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final platformChannelSpecifics = await _notificationDetails();
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  void updateBadge(int badgeCount) async {
    if (await FlutterAppBadger.isAppBadgeSupported()) {
      if (badgeCount > 0) {
        FlutterAppBadger.updateBadgeCount(badgeCount);
      } else {
        FlutterAppBadger.removeBadge();
      }
    }
  }
}
