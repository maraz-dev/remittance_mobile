import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

/// This Method is to get the device details for Security Purposes
Future<List<dynamic>> getDeviceDetails() async {
  String? deviceType;
  String? deviceToken;

  bool? isPlatformAndroid;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    isPlatformAndroid = false;
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceType = iosInfo.utsname.machine;
    deviceToken = iosInfo.identifierForVendor;
  } else if (Platform.isAndroid) {
    isPlatformAndroid = true;
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceType = androidInfo.model;
    deviceToken = androidInfo.id;
  }
  return [deviceType, deviceToken, isPlatformAndroid];
}
