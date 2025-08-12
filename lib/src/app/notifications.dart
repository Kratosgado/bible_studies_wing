import 'dart:convert';

import 'package:bible_studies_wing/src/data/models/lesson.dart';
import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badge_control/flutter_app_badge_control.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
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

    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      handleInitialMessage(initialMessage);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint("Got a message whilst in the foreground");
      debugPrint("Message data :: :: ${message.toMap().toString()}");

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

    FirebaseMessaging.onMessageOpenedApp.listen(handleInitialMessage);

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
      {required String message,
      required String topic,
      required String title,
      String? imageUrl,
      String? payload}) async {
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

      Map<String, String> data = {"id": payload ?? ""};
      var body = jsonEncode({
        'message': {
          "data": data,
          'topic': topic,
          'notification': {
            'body': message,
            'title': title,
          },
          "android": {
            "notification": {"image": imageUrl}
          },
          "apns": {
            "payload": {
              "aps": {"mutable-content": 1}
            },
            "fcm_options": {"image": imageUrl}
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
  }

  static void backgroundNotificationHandler(NotificationResponse details) {
    debugPrint("Background notification :: ${details.id}");
  }

  void selectNotification(RemoteMessage? message) {
    if (message != null && message.notification != null) {
      _messageStreamController.sink.add(message);
    }
  }

  Future<NotificationDetails> _notificationDetails({String? imageUrl, String? title}) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "channel id",
      "channel name",
      groupKey: 'com.example.bible_studies_wing',
      channelDescription: "Bible lessons channel",
      importance: Importance.max,
      playSound: true,
      priority: Priority.max,
      ticker: 'ticker',
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
      styleInformation: imageUrl != null
          ? BigPictureStyleInformation(
              FilePathAndroidBitmap(
                imageUrl,
              ),
              contentTitle: title,
            )
          : null,
    );
    const iosNotificationDetails = DarwinNotificationDetails(
      threadIdentifier: "thread1",
    );

    // final details = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    // if (details != null && details.didNotificationLaunchApp) {
    //   behaviorSubject.add(details.notificationResponse!.payload!);
    // }
    final platformChannelSpecifics = NotificationDetails(
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

  static void handleInitialMessage(RemoteMessage message) async {
    try {
      switch (message.from) {
        case "/topics/${AppService.announcementTopic}":
          await Get.toNamed(Routes.announcementRoute);
          break;
        case "/topics/${AppService.eventTopic}":
          await Get.toNamed(Routes.todaysEventRoute);
          break;
        case "/topics/${AppService.lessonTopic}":
          debugPrint("data :: :: ${message.data["id"]}");
          final lessonId = message.data["id"];
          final data = await FirebaseFirestore.instance.collection("lessons").doc(lessonId).get();
          final lesson = Lesson.fromJson(data.data()!);
          await Get.toNamed(Routes.lessonDetailRoute, arguments: lesson);
          debugPrint(":: :: :: :: \n :: :: :: Not done");
          break;
        default:
          debugPrint(":: :: ${message.from}");
      }
    } catch (e) {
      AppService.showErrorSnackbar(errorMessage: "Error processing notification", e: e);
    }
  }

  void updateBadge(int badgeCount) async {
    if (await FlutterAppBadgeControl.isAppBadgeSupported()) {
      if (badgeCount > 0) {
        FlutterAppBadgeControl.updateBadgeCount(badgeCount);
      } else {
        FlutterAppBadgeControl.removeBadge();
      }
    }
  }
}
