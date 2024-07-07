import 'package:bible_studies_wing/src/app/app.refs.dart';
import 'package:bible_studies_wing/src/app/notifications.dart';
import 'package:bible_studies_wing/src/data/models/member.dart';
import 'package:bible_studies_wing/src/resources/styles_manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/color_manager.dart';

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

  static String formatDate(DateTime date, {bool addYear = true}) {
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

    return "$month ${date.day}${addYear ? ", ${date.year}" : ""}";
  }

  // function to show loading popup
  static dynamic showLoadingPopup(
      {required Future<dynamic> Function() asyncFunction,
      required String message,
      required errorMessage}) async {
    try {
      await Get.showOverlay(
        asyncFunction: asyncFunction,
        loadingWidget: Center(
          child: SizedBox(
            height: Get.height * 0.1,
            width: Get.width * 0.8,
            child: Card(
              elevation: Spacing.s20,
              shape: const StadiumBorder(),
              child: Row(
                children: [
                  const CircularProgressIndicator(),
                  Text(message),
                ],
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      Get.snackbar(
        errorMessage,
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorManager.deepBblue,
        colorText: Colors.white,
      );
      debugPrint(e.toString());
    } finally {
      Get.back();
    }
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

  static Future<String?> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorManager.deepBblue,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      return formatDate(DateTime.parse(DateFormat('yyyy-MM-dd').format(pickedDate)),
          addYear: false);
    }
    return null;
  }

  static void dismissPopup(BuildContext ctx) {
    Navigator.of(ctx, rootNavigator: true).pop();
  }

  static int passcode = 1234;
}
