import 'dart:async';
import 'dart:developer';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
//import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkInternet() async {
  try {
    final res = await InternetConnectionChecker().hasConnection;
    // final connectivityResult = await (Connectivity().checkConnectivity());
    if (!res) {
      throw "Check your Connection and Try Again";
    } else {
      return res;
    }
  } catch (e) {
    throw e.toString();
  }
}

final connectionProvider = StreamProvider.autoDispose((ref) async* {
  StreamController<InternetConnectionStatus> stream =
      StreamController<InternetConnectionStatus>();

  var listener =
      InternetConnectionChecker().onStatusChange.listen((status) async {
    switch (status) {
      case InternetConnectionStatus.connected:
        break;
      case InternetConnectionStatus.disconnected:
        Fluttertoast.showToast(
            msg: "Check your Internet Connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.kErrorColor,
            textColor: AppColors.kWhiteColor,
            fontSize: 14.sp);

        break;
    }
    stream.add(status);
  });

  await for (final value in stream.stream) {
    log('Stream Value => ${value.toString()}');
    yield value;
  }
  ref.onDispose(() {
    stream.close();
    listener.cancel();
  });
});
