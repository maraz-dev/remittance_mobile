import 'dart:convert';

InitiateForgotPassReq initiateForgotPassReqFromJson(String str) =>
    InitiateForgotPassReq.fromJson(json.decode(str));

String initiateForgotPassReqToJson(InitiateForgotPassReq data) =>
    json.encode(data.toJson());

class InitiateForgotPassReq {
  String? partnerCode;
  String? email;
  String? pin;

  InitiateForgotPassReq({
    this.partnerCode,
    this.email,
    this.pin,
  });

  InitiateForgotPassReq copyWith({
    String? partnerCode,
    String? email,
    String? pin,
  }) =>
      InitiateForgotPassReq(
        partnerCode: partnerCode ?? this.partnerCode,
        email: email ?? this.email,
        pin: pin ?? this.pin,
      );

  factory InitiateForgotPassReq.fromJson(Map<String, dynamic> json) =>
      InitiateForgotPassReq(
        partnerCode: json["partnerCode"],
        email: json["email"],
        pin: json["pin"],
      );

  Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "email": email,
        "pin": pin,
      };
}
