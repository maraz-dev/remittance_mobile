import 'dart:convert';

LoginReq loginReqFromJson(String str) => LoginReq.fromJson(json.decode(str));

String loginReqToJson(LoginReq data) => json.encode(data.toJson());

class LoginReq {
  String? partnerCode;
  String? emailAddress;
  String? password;

  LoginReq({
    this.partnerCode,
    this.emailAddress,
    this.password,
  });

  LoginReq copyWith({
    String? partnerCode,
    String? emailAddress,
    String? password,
  }) =>
      LoginReq(
        partnerCode: partnerCode ?? this.partnerCode,
        emailAddress: emailAddress ?? this.emailAddress,
        password: password ?? this.password,
      );

  factory LoginReq.fromJson(Map<String, dynamic> json) => LoginReq(
        partnerCode: json["partnerCode"],
        emailAddress: json["emailAddress"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "emailAddress": emailAddress,
        "password": password,
      };
}
