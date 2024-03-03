import 'package:bible_studies_wing/src/app/app.refs.dart';
import 'package:bible_studies_wing/src/data/models/member.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AppService extends GetxService {
  static final AppPreferences preferences = AppPreferences();
  static late final Member currentMember;
  Future<void> init() async {
    debugPrint("AppService init");
    currentMember = preferences.getCurrentMember();
    super.onInit();
  }
}
