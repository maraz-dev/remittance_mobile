import 'dart:convert';

CreatePasswordReq createPasswordReqFromJson(String str) =>
    CreatePasswordReq.fromJson(json.decode(str));

String createPasswordReqToJson(CreatePasswordReq data) =>
    json.encode(data.toJson());

class CreatePasswordReq {
  final String? partnerCode;
  final String? password;
  final String? requestId;
  final String? channel;
  final String? deviceType;
  final String? deviceToken;
  final bool? isAndroidDevice;
  final String? location;
  final String? longitude;
  final String? latitude;

  CreatePasswordReq({
    this.partnerCode,
    this.password,
    this.requestId,
    this.channel,
    this.deviceType,
    this.deviceToken,
    this.isAndroidDevice,
    this.location,
    this.longitude,
    this.latitude,
  });

  CreatePasswordReq copyWith({
    String? partnerCode,
    String? password,
    String? requestId,
    String? channel,
    String? deviceType,
    String? deviceToken,
    bool? isAndroidDevice,
    String? location,
    String? longitude,
    String? latitude,
  }) =>
      CreatePasswordReq(
        partnerCode: partnerCode ?? this.partnerCode,
        password: password ?? this.password,
        requestId: requestId ?? this.requestId,
        channel: channel ?? this.channel,
        deviceType: deviceType ?? this.deviceType,
        deviceToken: deviceToken ?? this.deviceToken,
        isAndroidDevice: isAndroidDevice ?? this.isAndroidDevice,
        location: location ?? this.location,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
      );

  factory CreatePasswordReq.fromJson(Map<String, dynamic> json) =>
      CreatePasswordReq(
        partnerCode: json["partnerCode"],
        password: json["password"],
        requestId: json["requestId"],
        channel: json["Channel"],
        deviceType: json["DeviceType"],
        deviceToken: json["DeviceToken"],
        isAndroidDevice: json["IsAndroidDevice"],
        location: json["Location"],
        longitude: json["Longitude"],
        latitude: json["Latitude"],
      );

  Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "password": password,
        "requestId": requestId,
        "Channel": channel,
        "DeviceType": deviceType,
        "DeviceToken": deviceToken,
        "IsAndroidDevice": isAndroidDevice,
        "Location": location,
        "Longitude": longitude,
        "Latitude": latitude,
      };
}
