import 'dart:convert';

UssdFundingDto ussdFundingDtoFromJson(String str) => UssdFundingDto.fromJson(json.decode(str));

String ussdFundingDtoToJson(UssdFundingDto data) => json.encode(data.toJson());

class UssdFundingDto {
  final String? mode;
  final String? note;
  final String? paymentCode;
  final int? flwTransactionId;
  final double? amount;
  final String? requestId;

  UssdFundingDto({
    this.mode,
    this.note,
    this.paymentCode,
    this.flwTransactionId,
    this.amount,
    this.requestId,
  });

  factory UssdFundingDto.fromJson(Map<String, dynamic> json) => UssdFundingDto(
        mode: json["mode"],
        note: json["note"],
        paymentCode: json["paymentCode"],
        flwTransactionId: json["flwTransactionId"],
        amount: json["amount"]?.toDouble(),
        requestId: json["requestId"],
      );

  Map<String, dynamic> toJson() => {
        "mode": mode,
        "note": note,
        "paymentCode": paymentCode,
        "flwTransactionId": flwTransactionId,
        "amount": amount,
        "requestId": requestId,
      };
}
