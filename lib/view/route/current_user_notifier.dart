// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';

class LoginInfo extends ChangeNotifier {
  Ref ref;
  String get userName => _userName;
  String _userName = '';
  bool _isLoggedIn = SharedPrefManager.isLoggedIn;
  LoginInfo(
    this.ref,
  );

  /// Whether a user has logged in.
  bool get loggedIn => _userName.isNotEmpty;
  bool get newUser => _isLoggedIn;

  /// Logs in a user.
  void login(String userName) {
    _userName = userName;
    notifyListeners();
  }

  void isLoggedIn() {
    _isLoggedIn = true;
    SharedPrefManager.isLoggedIn = true;
    notifyListeners();
  }

  void logOutUser() async {
    _isLoggedIn = false;
    notifyListeners();
  }

  /// Logs out the current user.
  void logout() {
    _userName = '';
    notifyListeners();
  }
}

final userStateProvider = ChangeNotifierProvider<LoginInfo>((ref) {
  return LoginInfo(ref);
});
