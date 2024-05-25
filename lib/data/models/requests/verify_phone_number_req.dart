import 'dart:convert';

VerifyPhoneNumberReq countryModelFromJson(String str) =>
    VerifyPhoneNumberReq.fromJson(json.decode(str));

String countryModelToJson(VerifyPhoneNumberReq data) =>
    json.encode(data.toJson());

class VerifyPhoneNumberReq {
  String? partnerCode;
  String? requestId;
  String? otp;

  VerifyPhoneNumberReq({
    this.partnerCode,
    this.requestId,
    this.otp,
  });

  VerifyPhoneNumberReq copyWith({
    String? partnerCode,
    String? requestId,
    String? otp,
  }) =>
      VerifyPhoneNumberReq(
        partnerCode: partnerCode ?? this.partnerCode,
        requestId: requestId ?? this.requestId,
        otp: otp ?? this.otp,
      );

  factory VerifyPhoneNumberReq.fromJson(Map<String, dynamic> json) =>
      VerifyPhoneNumberReq(
        partnerCode: json["partnerCode"],
        requestId: json["requestId"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "requestId": requestId,
        "otp": otp,
      };
}
