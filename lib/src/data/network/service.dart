import 'package:bible_studies_wing/src/app/app.refs.dart';
import 'package:bible_studies_wing/src/app/notifications.dart';
import 'package:bible_studies_wing/src/data/models/member.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppService extends GetxService {
  static final AppPreferences preferences = AppPreferences();
  static final notificationService = PushNotificationService();

  static const String lessonTopic = "lesson";
  static const String eventTopic = "event";
  static const String announcementTopic = "announcement";
  static const projectId = "biblestudywing-32f3b";
  static const firebaseToken = "bEhCWyKiJAQRjRJrgIHzVrWFR_CVfxTCGfhFcuzjlGs";

  static Member? currentMember;
  Future<void> init() async {
    debugPrint("AppService init");
    currentMember = preferences.getCurrentMember();
    notificationService.initialize();
    super.onInit();
  }

  static String formatDate(DateTime date) {
    String month = switch (date.month) {
      DateTime.january => "January",
      DateTime.february => "February",
      DateTime.march => "March",
      DateTime.april => "April",
      DateTime.may => "May",
      DateTime.june => "June",
      DateTime.july => "July",
      DateTime.august => "August",
      DateTime.september => "September",
      DateTime.october => "October",
      DateTime.november => "November",
      DateTime.december => "December",
      _ => "",
    };

    return "$month ${date.day}, ${date.year}";
  }

  // function to show loading popup
  static dynamic showLoadingPopup(BuildContext ctx, String message) {
    return showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Card(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                Text(message),
              ],
            ),
          ),
        );
      },
    );
  }

  // function to view image
  static void viewPicture(Widget child, String title, String imageUrl) {
    Get.to(() => Hero(
        tag: imageUrl,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(title),
          ),
          body: Center(
            child: child,
          ),
        )));
  }

  static void dismissPopup(BuildContext ctx) {
    Navigator.of(ctx, rootNavigator: true).pop();
  }

  static int passcode = 1234;
}
