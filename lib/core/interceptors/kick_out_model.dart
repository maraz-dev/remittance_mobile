import 'dart:developer';

import 'package:flutter/foundation.dart';

class KickOutListener {
  KickOutListener();

  kickOut() async {
    // Clear the Auth Token
    // var storage = inject.get<SecureStorageBase>();
    // var accessToken = ApiEndpoints.instance.token;
    // await storage.deleteData(accessToken);

    // Take them back to the Sign In Screen
    if (kDebugMode) {
      log("User KICKED OUT!!!");
    }
    // rootNavigation.currentContext?.goNamed(
    //   LoginScreen.path,
    // );
  }
}
