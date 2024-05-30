import 'dart:convert';

ChangePasswordReq changePasswordReqFromJson(String str) =>
    ChangePasswordReq.fromJson(json.decode(str));

String changePasswordReqToJson(ChangePasswordReq data) =>
    json.encode(data.toJson());

class ChangePasswordReq {
  String? emailAddress;
  String? newPassword;
  String? confirmNewPassword;

  ChangePasswordReq({
    this.emailAddress,
    this.newPassword,
    this.confirmNewPassword,
  });

  ChangePasswordReq copyWith({
    String? emailAddress,
    String? newPassword,
    String? confirmNewPassword,
  }) =>
      ChangePasswordReq(
        emailAddress: emailAddress ?? this.emailAddress,
        newPassword: newPassword ?? this.newPassword,
        confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      );

  factory ChangePasswordReq.fromJson(Map<String, dynamic> json) =>
      ChangePasswordReq(
        emailAddress: json["emailAddress"],
        newPassword: json["newPassword"],
        confirmNewPassword: json["confirmNewPassword"],
      );

  Map<String, dynamic> toJson() => {
        "emailAddress": emailAddress,
        "newPassword": newPassword,
        "confirmNewPassword": confirmNewPassword,
      };
}
