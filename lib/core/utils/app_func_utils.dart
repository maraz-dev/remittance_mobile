import 'dart:io';

import 'package:share_plus/share_plus.dart';

class AppUtils {
  static Future<ShareResult> shareFile(File bytes) async {
    final shots = XFile(bytes.path);
    final res = await Share.shareXFiles(
      [shots],
    );
    return res;
  }
}
