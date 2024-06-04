import 'dart:convert';

CompleteForgotPassReq completeForgotPassReqFromJson(String str) =>
    CompleteForgotPassReq.fromJson(json.decode(str));

String completeForgotPassReqToJson(CompleteForgotPassReq data) =>
    json.encode(data.toJson());

class CompleteForgotPassReq {
  String? requestId;
  String? email;
  String? password;
  String? partnerCode;

  CompleteForgotPassReq({
    this.requestId,
    this.email,
    this.password,
    this.partnerCode,
  });

  CompleteForgotPassReq copyWith({
    String? requestId,
    String? email,
    String? password,
    String? partnerCode,
  }) =>
      CompleteForgotPassReq(
        requestId: requestId ?? this.requestId,
        email: email ?? this.email,
        password: password ?? this.password,
        partnerCode: partnerCode ?? this.partnerCode,
      );

  factory CompleteForgotPassReq.fromJson(Map<String, dynamic> json) =>
      CompleteForgotPassReq(
        requestId: json["requestId"],
        email: json["email"],
        password: json["password"],
        partnerCode: json["partnerCode"],
      );

  Map<String, dynamic> toJson() => {
        "requestId": requestId,
        "email": email,
        "password": password,
        "partnerCode": partnerCode,
      };
}
