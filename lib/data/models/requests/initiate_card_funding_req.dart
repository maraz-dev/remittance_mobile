import 'dart:convert';

InitiateCardFundingReq initiateFlutterwaveCardReqFromJson(String str) =>
    InitiateCardFundingReq.fromJson(json.decode(str));

String initiateFlutterwaveCardReqToJson(InitiateCardFundingReq data) =>
    json.encode(data.toJson());

class InitiateCardFundingReq {
  final String? cardNumber;
  final String? expiryMonth;
  final String? expiryYear;
  final String? cvv;
  final String? currency;
  final String? redirectUrl;
  final int? amount;
  final int? charge;

  InitiateCardFundingReq({
    this.cardNumber,
    this.expiryMonth,
    this.expiryYear,
    this.cvv,
    this.currency,
    this.redirectUrl,
    this.amount,
    this.charge,
  });

  InitiateCardFundingReq copyWith({
    String? cardNumber,
    String? expiryMonth,
    String? expiryYear,
    String? cvv,
    String? currency,
    String? redirectUrl,
    int? amount,
    int? charge,
  }) =>
      InitiateCardFundingReq(
        cardNumber: cardNumber ?? this.cardNumber,
        expiryMonth: expiryMonth ?? this.expiryMonth,
        expiryYear: expiryYear ?? this.expiryYear,
        cvv: cvv ?? this.cvv,
        currency: currency ?? this.currency,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        amount: amount ?? this.amount,
        charge: charge ?? this.charge,
      );

  factory InitiateCardFundingReq.fromJson(Map<String, dynamic> json) =>
      InitiateCardFundingReq(
        cardNumber: json["cardNumber"],
        expiryMonth: json["expiryMonth"],
        expiryYear: json["expiryYear"],
        cvv: json["cvv"],
        currency: json["currency"],
        redirectUrl: json["redirectUrl"],
        amount: json["amount"],
        charge: json["charge"],
      );

  Map<String, dynamic> toJson() => {
        "cardNumber": cardNumber,
        "expiryMonth": expiryMonth,
        "expiryYear": expiryYear,
        "cvv": cvv,
        "currency": currency,
        "redirectUrl": redirectUrl,
        "amount": amount,
        "charge": charge,
      };
}
