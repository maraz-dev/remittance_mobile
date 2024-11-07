import 'dart:convert';

CreatePasswordReq createPasswordReqFromJson(String str) =>
    CreatePasswordReq.fromJson(json.decode(str));

String createPasswordReqToJson(CreatePasswordReq data) =>
    json.encode(data.toJson());

class CreatePasswordReq {
  final String? partnerCode;
  final String? password;
  final String? requestId;
  final String? clientChannel;
  final String? deviceType;
  final String? deviceId;
  final String? deviceToken;
  final bool? isAndroidDevice;
  final String? ipAddress;
  final String? location;
  final String? longitude;
  final String? latitude;

  CreatePasswordReq({
    this.partnerCode,
    this.password,
    this.requestId,
    this.clientChannel,
    this.deviceType,
    this.deviceId,
    this.deviceToken,
    this.isAndroidDevice,
    this.ipAddress,
    this.location,
    this.longitude,
    this.latitude,
  });

  CreatePasswordReq copyWith({
    String? partnerCode,
    String? password,
    String? requestId,
    String? clientChannel,
    String? deviceType,
    String? deviceId,
    String? deviceToken,
    bool? isAndroidDevice,
    String? ipAddress,
    String? location,
    String? longitude,
    String? latitude,
  }) =>
      CreatePasswordReq(
        partnerCode: partnerCode ?? this.partnerCode,
        password: password ?? this.password,
        requestId: requestId ?? this.requestId,
        clientChannel: clientChannel ?? this.clientChannel,
        deviceType: deviceType ?? this.deviceType,
        deviceId: deviceId ?? this.deviceId,
        deviceToken: deviceToken ?? this.deviceToken,
        isAndroidDevice: isAndroidDevice ?? this.isAndroidDevice,
        ipAddress: ipAddress ?? this.ipAddress,
        location: location ?? this.location,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
      );

  factory CreatePasswordReq.fromJson(Map<String, dynamic> json) =>
      CreatePasswordReq(
        partnerCode: json["partnerCode"],
        password: json["password"],
        requestId: json["requestId"],
        clientChannel: json["clientChannel"],
        deviceType: json["deviceType"],
        deviceId: json["deviceId"],
        deviceToken: json["deviceToken"],
        isAndroidDevice: json["isAndroidDevice"],
        ipAddress: json["ipAddress"],
        location: json["location"],
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "password": password,
        "requestId": requestId,
        "clientChannel": clientChannel,
        "deviceType": deviceType,
        "deviceId": deviceId,
        "deviceToken": deviceToken,
        "isAndroidDevice": isAndroidDevice,
        "ipAddress": ipAddress,
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
      };
}
