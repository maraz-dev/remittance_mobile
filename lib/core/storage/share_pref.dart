import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static late SharedPreferences prefs;

  static set isFirstLaunch(bool isFirstLaunch) =>
      prefs.setBool("isFirstLaunch", isFirstLaunch);
  static bool get isFirstLaunch => prefs.getBool("isFirstLaunch") ?? true;

  static set accountStatus(String accountStatus) =>
      prefs.setString("accountStatus", accountStatus);
  static String get accountStatus => prefs.getString("accountStatus") ?? '';

  static set email(String email) => prefs.setString("email", email);
  static String get email => prefs.getString("email") ?? '';

  static set userId(String userId) => prefs.setString("userId", userId);
  static String get userId => prefs.getString("userId") ?? '';

  /// user Preference
  static set avatar(String avatar) => prefs.setString("avatar", avatar);
  static String get avatar => prefs.getString("avatar") ?? '';

  static set gender(String gender) => prefs.setString("gender", gender);
  static String get gender => prefs.getString("gender") ?? '';

  static set accountNo(String accountNo) =>
      prefs.setString("accountNo", accountNo);
  static String get accountNo => prefs.getString("accountNo") ?? '';

  static void clear() {
    //prefs.clear();
    SharedPrefManager.isFirstLaunch = false;
  }

// Init Shared Preference
  static Future<SharedPreferences> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
