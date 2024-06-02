import 'dart:convert';

LoginReq loginReqFromJson(String str) => LoginReq.fromJson(json.decode(str));

String loginReqToJson(LoginReq data) => json.encode(data.toJson());

class LoginReq {
  String? partnerCode;
  String? emailAddress;
  String? password;
  String? deviceType;
  String? deviceToken;

  LoginReq({
    this.partnerCode,
    this.emailAddress,
    this.password,
    this.deviceType,
    this.deviceToken,
  });

  LoginReq copyWith({
    String? partnerCode,
    String? emailAddress,
    String? password,
    String? deviceType,
    String? deviceToken,
  }) =>
      LoginReq(
        partnerCode: partnerCode ?? this.partnerCode,
        emailAddress: emailAddress ?? this.emailAddress,
        password: password ?? this.password,
        deviceType: deviceType ?? this.deviceType,
        deviceToken: deviceToken ?? this.deviceToken,
      );

  factory LoginReq.fromJson(Map<String, dynamic> json) => LoginReq(
        partnerCode: json["partnerCode"],
        emailAddress: json["emailAddress"],
        password: json["password"],
        deviceType: json["deviceType"],
        deviceToken: json["deviceToken"],
      );

  Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "emailAddress": emailAddress,
        "password": password,
        "deviceType": deviceType,
        "deviceToken": deviceToken,
      };
}
