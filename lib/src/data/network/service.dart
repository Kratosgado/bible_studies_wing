import 'package:bible_studies_wing/src/app/app.refs.dart';
import 'package:bible_studies_wing/src/data/models/member.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AppService extends GetxService {
  static final AppPreferences preferences = AppPreferences();
  static Member? currentMember;
  Future<void> init() async {
    debugPrint("AppService init");
    currentMember = preferences.getCurrentMember();
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

  static int passcode = 1234;
}
