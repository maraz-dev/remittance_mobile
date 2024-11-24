import 'dart:convert';

InitiateForgotPassReq initiateForgotPassReqFromJson(String str) =>
    InitiateForgotPassReq.fromJson(json.decode(str));

String initiateForgotPassReqToJson(InitiateForgotPassReq data) => json.encode(data.toJson());

class InitiateForgotPassReq {
  String? partnerCode;
  String? email;

  InitiateForgotPassReq({
    this.partnerCode,
    this.email,
  });

  InitiateForgotPassReq copyWith({
    String? partnerCode,
    String? email,
  }) =>
      InitiateForgotPassReq(
        partnerCode: partnerCode ?? this.partnerCode,
        email: email ?? this.email,
      );

  factory InitiateForgotPassReq.fromJson(Map<String, dynamic> json) => InitiateForgotPassReq(
        partnerCode: json["partnerCode"],
        email: json["emailAddress"],
      );

  Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "emailAddress": email,
      };
}
