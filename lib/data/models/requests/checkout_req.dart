import 'dart:convert';

CheckoutReq checkoutReqFromJson(String str) => CheckoutReq.fromJson(json.decode(str));

String checkoutReqToJson(CheckoutReq data) => json.encode(data.toJson());

class CheckoutReq {
  final String? currency;
  final String? accountNumber;
  final String? redirectUrl;
  final num? amount;
  final num? charge;

  CheckoutReq({
    this.currency,
    this.accountNumber,
    this.redirectUrl,
    this.amount,
    this.charge,
  });

  CheckoutReq copyWith({
    String? currency,
    String? accountNumber,
    String? redirectUrl,
    int? amount,
    int? charge,
  }) =>
      CheckoutReq(
        currency: currency ?? this.currency,
        accountNumber: accountNumber ?? this.accountNumber,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        amount: amount ?? this.amount,
        charge: charge ?? this.charge,
      );

  factory CheckoutReq.fromJson(Map<String, dynamic> json) => CheckoutReq(
        currency: json["currency"],
        accountNumber: json["accountNumber"],
        redirectUrl: json["redirectUrl"],
        amount: json["amount"],
        charge: json["charge"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "accountNumber": accountNumber,
        "redirectUrl": redirectUrl,
        "amount": amount,
        "charge": charge,
      };
}
