import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static late SharedPreferences prefs;

  static set isFirstLaunch(bool isFirstLaunch) =>
      prefs.setBool("isFirstLaunch", isFirstLaunch);
  static bool get isFirstLaunch => prefs.getBool("isFirstLaunch") ?? true;

  static set email(String email) => prefs.setString("email", email);
  static String get email => prefs.getString("email") ?? '';

  static set userId(String userId) => prefs.setString("userId", userId);
  static String get userId => prefs.getString("userId") ?? '';

  static set isNewLogin(bool isNewLogin) =>
      prefs.setBool("isNewLogin", isNewLogin);
  static bool get isNewLogin => prefs.getBool("isNewLogin") ?? false;

  static set isPINSet(bool isPINSet) => prefs.setBool("isPINSet", isPINSet);
  static bool get isPINSet => prefs.getBool("isPINSet") ?? false;

  static set isKycComplete(bool isKycComplete) =>
      prefs.setBool("isKycComplete", isKycComplete);
  static bool get isKycComplete => prefs.getBool("isKycComplete") ?? false;

  static set isSecurityQuestionSet(bool isSecurityQuestionSet) =>
      prefs.setBool("isSecurityQuestionSet", isKycComplete);
  static bool get isSecurityQuestionSet =>
      prefs.getBool("isSecurityQuestionSet") ?? false;

  static set kycPosition(String kycPosition) =>
      prefs.setString("kycPosition", kycPosition);
  static String get kycPosition => prefs.getString("kycPosition") ?? '';

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
