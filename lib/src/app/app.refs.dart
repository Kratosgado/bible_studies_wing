import 'package:bible_studies_wing/src/data/models/member.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _preferences;
  AppPreferences(this._preferences);

  static Future<AppPreferences> get instance async => await getInstance();

  static Future<AppPreferences> getInstance() async {
    final preferences = await SharedPreferences.getInstance();
    return AppPreferences(preferences);
  }

  bool isUserLoggedIn() {
    return _preferences.getBool('isUserLoggedIn') ?? false;
  }

  Future<void> setCurrentMember(Member member) async {
    await _preferences.setString('currentMember', member.toJson().toString());
  }

  Future<void> setUserLoggedIn(bool value) async {
    await _preferences.setBool('isUserLoggedIn', value);
  }

  Future<void> logout() async {
    await _preferences.setBool('isUserLoggedIn', false);
  }
}
