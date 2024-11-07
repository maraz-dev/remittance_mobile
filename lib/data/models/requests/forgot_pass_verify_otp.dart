import 'dart:convert';

ForgotPasswordOtpReq forgotPasswordOtpReqFromJson(String str) =>
    ForgotPasswordOtpReq.fromJson(json.decode(str));

String forgotPasswordOtpReqToJson(ForgotPasswordOtpReq data) =>
    json.encode(data.toJson());

class ForgotPasswordOtpReq {
  String? requestId;
  String? email;
  String? otp;

  ForgotPasswordOtpReq({
    this.requestId,
    this.email,
    this.otp,
  });

  ForgotPasswordOtpReq copyWith({
    String? requestId,
    String? email,
    String? otp,
  }) =>
      ForgotPasswordOtpReq(
        requestId: requestId ?? this.requestId,
        email: email ?? this.email,
        otp: otp ?? this.otp,
      );

  factory ForgotPasswordOtpReq.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordOtpReq(
        requestId: json["requestId"],
        email: json["email"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "requestId": requestId,
        "email": email,
        "otp": otp,
      };
}
