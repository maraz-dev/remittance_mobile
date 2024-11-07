import 'dart:convert';

LoginReq loginReqFromJson(String str) => LoginReq.fromJson(json.decode(str));

String loginReqToJson(LoginReq data) => json.encode(data.toJson());

class LoginReq {
  final String? partnerCode;
  final String? emailAddress;
  final String? password;
  final String? channel;
  final String? deviceType;
  final String? deviceToken;
  final String? ipAddress;
  final String? location;
  final String? latitude;
  final String? longitude;

  LoginReq({
    this.partnerCode,
    this.emailAddress,
    this.password,
    this.channel,
    this.deviceType,
    this.deviceToken,
    this.ipAddress,
    this.location,
    this.latitude,
    this.longitude,
  });

  LoginReq copyWith({
    String? partnerCode,
    String? emailAddress,
    String? password,
    String? channel,
    String? deviceType,
    String? deviceToken,
    String? ipAddress,
    String? location,
    String? latitude,
    String? longitude,
  }) =>
      LoginReq(
        partnerCode: partnerCode ?? this.partnerCode,
        emailAddress: emailAddress ?? this.emailAddress,
        password: password ?? this.password,
        channel: channel ?? this.channel,
        deviceType: deviceType ?? this.deviceType,
        deviceToken: deviceToken ?? this.deviceToken,
        ipAddress: ipAddress ?? this.ipAddress,
        location: location ?? this.location,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory LoginReq.fromJson(Map<String, dynamic> json) => LoginReq(
        partnerCode: json["partnerCode"],
        emailAddress: json["emailAddress"],
        password: json["password"],
        channel: json["Channel"],
        deviceType: json["deviceType"],
        deviceToken: json["deviceToken"],
        ipAddress: json["ipAddress"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "emailAddress": emailAddress,
        "password": password,
        "Channel": channel,
        "deviceType": deviceType,
        "deviceToken": deviceToken,
        "ipAddress": ipAddress,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
      };
}
