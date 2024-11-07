import 'dart:convert';

VerifyFundingTransxModel verifyTransxModelFromJson(String str) =>
    VerifyFundingTransxModel.fromJson(json.decode(str));

String verifyTransxModelToJson(VerifyFundingTransxModel data) =>
    json.encode(data.toJson());

class VerifyFundingTransxModel {
  final bool? isSuccessful;
  final bool? isCompleted;
  final String? reference;
  final String? message;

  VerifyFundingTransxModel({
    this.isSuccessful,
    this.isCompleted,
    this.reference,
    this.message,
  });

  factory VerifyFundingTransxModel.fromJson(Map<String, dynamic> json) =>
      VerifyFundingTransxModel(
        isSuccessful: json["isSuccessful"],
        isCompleted: json["isCompleted"],
        reference: json["reference"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "isSuccessful": isSuccessful,
        "isCompleted": isCompleted,
        "reference": reference,
        "message": message,
      };
}
