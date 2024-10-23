import 'dart:convert';

InitiateCardFundingReq initiateCardFundingReqFromJson(String str) =>
    InitiateCardFundingReq.fromJson(json.decode(str));

String initiateCardFundingReqToJson(InitiateCardFundingReq data) => json.encode(data.toJson());

class InitiateCardFundingReq {
  final String? cardNumber;
  final String? expiryMonth;
  final String? expiryYear;
  final String? cvv;
  final String? currency;
  final String? accountNumber;
  final String? redirectUrl;
  final double? amount;
  final double? charge;

  InitiateCardFundingReq({
    this.cardNumber,
    this.expiryMonth,
    this.expiryYear,
    this.cvv,
    this.currency,
    this.accountNumber,
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
    String? accountNumber,
    String? redirectUrl,
    double? amount,
    double? charge,
  }) =>
      InitiateCardFundingReq(
        cardNumber: cardNumber ?? this.cardNumber,
        expiryMonth: expiryMonth ?? this.expiryMonth,
        expiryYear: expiryYear ?? this.expiryYear,
        cvv: cvv ?? this.cvv,
        currency: currency ?? this.currency,
        accountNumber: accountNumber ?? this.accountNumber,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        amount: amount ?? this.amount,
        charge: charge ?? this.charge,
      );

  factory InitiateCardFundingReq.fromJson(Map<String, dynamic> json) => InitiateCardFundingReq(
        cardNumber: json["cardNumber"],
        expiryMonth: json["expiryMonth"],
        expiryYear: json["expiryYear"],
        cvv: json["cvv"],
        currency: json["currency"],
        accountNumber: json["accountNumber"],
        redirectUrl: json["redirectUrl"],
        amount: json["amount"].toDouble(),
        charge: json["charge"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "cardNumber": cardNumber,
        "expiryMonth": expiryMonth,
        "expiryYear": expiryYear,
        "cvv": cvv,
        "currency": currency,
        "accountNumber": accountNumber,
        "redirectUrl": redirectUrl,
        "amount": amount,
        "charge": charge,
      };
}
