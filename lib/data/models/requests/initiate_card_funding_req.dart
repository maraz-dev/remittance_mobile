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
  final double? amount;
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
    double? amount,
    int? charge,
    dynamic authorization,
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
        amount: json["amount"].toDouble(),
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

class CardPinAuthorization {
  final String? mode;
  final String? pin;

  CardPinAuthorization({
    this.mode,
    this.pin,
  });

  factory CardPinAuthorization.fromJson(Map<String, dynamic> json) =>
      CardPinAuthorization(
        mode: json["mode"],
        pin: json["pin"],
      );

  Map<String, dynamic> toJson() => {
        "mode": mode,
        "pin": pin,
      };
}

class CardAvsAuthorization {
  final String? mode;
  final String? city;
  final String? address;
  final String? state;
  final String? country;
  final String? zipcode;

  CardAvsAuthorization({
    this.mode,
    this.city,
    this.address,
    this.state,
    this.country,
    this.zipcode,
  });

  factory CardAvsAuthorization.fromJson(Map<String, dynamic> json) =>
      CardAvsAuthorization(
        mode: json["mode"],
        city: json["city"],
        address: json["address"],
        state: json["state"],
        country: json["country"],
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toJson() => {
        "mode": mode,
        "city": city,
        "address": address,
        "state": state,
        "country": country,
        "zipcode": zipcode,
      };
}
