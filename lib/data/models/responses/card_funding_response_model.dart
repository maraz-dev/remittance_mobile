import 'dart:convert';

CardFundingResponseModel cardFundingResponseModelFromJson(String str) =>
    CardFundingResponseModel.fromJson(json.decode(str));

String cardFundingResponseModelToJson(CardFundingResponseModel data) =>
    json.encode(data.toJson());

class CardFundingResponseModel {
  final String? mode;
  final String? redirect;
  final dynamic message;
  final List<dynamic>? fields;
  final int? flwTransactionId;
  final int? amount;
  final String? requestId;

  CardFundingResponseModel({
    this.mode,
    this.redirect,
    this.message,
    this.fields,
    this.flwTransactionId,
    this.amount,
    this.requestId,
  });

  factory CardFundingResponseModel.fromJson(Map<String, dynamic> json) =>
      CardFundingResponseModel(
        mode: json["mode"],
        redirect: json["redirect"],
        message: json["message"],
        fields: json["fields"] == null
            ? []
            : List<dynamic>.from(json["fields"]!.map((x) => x)),
        flwTransactionId: json["flwTransactionId"],
        amount: json["amount"],
        requestId: json["requestId"],
      );

  Map<String, dynamic> toJson() => {
        "mode": mode,
        "redirect": redirect,
        "message": message,
        "fields":
            fields == null ? [] : List<dynamic>.from(fields!.map((x) => x)),
        "flwTransactionId": flwTransactionId,
        "amount": amount,
        "requestId": requestId,
      };
}
