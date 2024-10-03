import 'dart:convert';

ValidateCardFundingModel validateCardFundingModelFromJson(String str) =>
    ValidateCardFundingModel.fromJson(json.decode(str));

String validateCardFundingModelToJson(ValidateCardFundingModel data) =>
    json.encode(data.toJson());

class ValidateCardFundingModel {
  final bool? isValid;
  final int? flwTransactionId;
  final num? amount;
  final String? requestId;

  ValidateCardFundingModel({
    this.isValid,
    this.flwTransactionId,
    this.amount,
    this.requestId,
  });

  factory ValidateCardFundingModel.fromJson(Map<String, dynamic> json) =>
      ValidateCardFundingModel(
        isValid: json["isValid"] ?? false,
        flwTransactionId: json["flwTransactionId"] ?? 0,
        amount: json["amount"],
        requestId: json["requestId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "isValid": isValid,
        "flwTransactionId": flwTransactionId,
        "amount": amount,
        "requestId": requestId,
      };
}
