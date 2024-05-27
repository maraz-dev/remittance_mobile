import 'dart:convert';

CreatePasswordReq createPasswordReqFromJson(String str) =>
    CreatePasswordReq.fromJson(json.decode(str));

String createPasswordReqToJson(CreatePasswordReq data) =>
    json.encode(data.toJson());

class CreatePasswordReq {
  String? partnerCode;
  String? requestId;
  String? password;

  CreatePasswordReq({
    this.partnerCode,
    this.requestId,
    this.password,
  });

  CreatePasswordReq copyWith({
    String? partnerCode,
    String? requestId,
    String? password,
  }) =>
      CreatePasswordReq(
        partnerCode: partnerCode ?? this.partnerCode,
        requestId: requestId ?? this.requestId,
        password: password ?? this.password,
      );

  factory CreatePasswordReq.fromJson(Map<String, dynamic> json) =>
      CreatePasswordReq(
        partnerCode: json["partnerCode"],
        requestId: json["requestId"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "requestId": requestId,
        "password": password,
      };
}
