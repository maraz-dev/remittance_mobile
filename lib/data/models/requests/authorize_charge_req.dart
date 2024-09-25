import 'dart:convert';

PinAuthorizationReq pinAuthorizationReqFromJson(String str) =>
    PinAuthorizationReq.fromJson(json.decode(str));

String pinAuthorizationReqToJson(PinAuthorizationReq data) =>
    json.encode(data.toJson());

class PinAuthorizationReq {
  final String? cardNumber;
  final String? expiryMonth;
  final String? expiryYear;
  final String? cvv;
  final String? redirectUrl;
  final String? requestId;
  final String? email;
  final PinModeAuthorization? authorization;

  PinAuthorizationReq({
    this.cardNumber,
    this.expiryMonth,
    this.expiryYear,
    this.cvv,
    this.redirectUrl,
    this.requestId,
    this.email,
    this.authorization,
  });

  PinAuthorizationReq copyWith({
    String? cardNumber,
    String? expiryMonth,
    String? expiryYear,
    String? cvv,
    String? redirectUrl,
    String? requestId,
    String? email,
    PinModeAuthorization? authorization,
  }) =>
      PinAuthorizationReq(
        cardNumber: cardNumber ?? this.cardNumber,
        expiryMonth: expiryMonth ?? this.expiryMonth,
        expiryYear: expiryYear ?? this.expiryYear,
        cvv: cvv ?? this.cvv,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        requestId: requestId ?? this.requestId,
        email: email ?? this.email,
        authorization: authorization ?? this.authorization,
      );

  factory PinAuthorizationReq.fromJson(Map<String, dynamic> json) =>
      PinAuthorizationReq(
        cardNumber: json["cardNumber"],
        expiryMonth: json["expiryMonth"],
        expiryYear: json["expiryYear"],
        cvv: json["cvv"],
        redirectUrl: json["redirectUrl"],
        requestId: json["requestId"],
        email: json["email"],
        authorization: json["authorization"] == null
            ? null
            : PinModeAuthorization.fromJson(json["authorization"]),
      );

  Map<String, dynamic> toJson() => {
        "cardNumber": cardNumber,
        "expiryMonth": expiryMonth,
        "expiryYear": expiryYear,
        "cvv": cvv,
        "redirectUrl": redirectUrl,
        "requestId": requestId,
        "email": email,
        "authorization": authorization?.toJson(),
      };
}

class PinModeAuthorization {
  final String? mode;
  final String? pin;

  PinModeAuthorization({
    this.mode,
    this.pin,
  });

  PinModeAuthorization copyWith({
    String? mode,
    String? pin,
  }) =>
      PinModeAuthorization(
        mode: mode ?? this.mode,
        pin: pin ?? this.pin,
      );

  factory PinModeAuthorization.fromJson(Map<String, dynamic> json) =>
      PinModeAuthorization(
        mode: json["mode"],
        pin: json["pin"],
      );

  Map<String, dynamic> toJson() => {
        "mode": mode,
        "pin": pin,
      };
}

class AvsAuthorizationReq {
  final String? cardNumber;
  final String? expiryMonth;
  final String? expiryYear;
  final String? cvv;
  final String? redirectUrl;
  final String? requestId;
  final String? email;
  final AvsModeAuthorization? authorization;

  AvsAuthorizationReq({
    this.cardNumber,
    this.expiryMonth,
    this.expiryYear,
    this.cvv,
    this.redirectUrl,
    this.requestId,
    this.email,
    this.authorization,
  });

  AvsAuthorizationReq copyWith({
    String? cardNumber,
    String? expiryMonth,
    String? expiryYear,
    String? cvv,
    String? redirectUrl,
    String? requestId,
    String? email,
    AvsModeAuthorization? authorization,
  }) =>
      AvsAuthorizationReq(
        cardNumber: cardNumber ?? this.cardNumber,
        expiryMonth: expiryMonth ?? this.expiryMonth,
        expiryYear: expiryYear ?? this.expiryYear,
        cvv: cvv ?? this.cvv,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        requestId: requestId ?? this.requestId,
        email: email ?? this.email,
        authorization: authorization ?? this.authorization,
      );

  factory AvsAuthorizationReq.fromJson(Map<String, dynamic> json) =>
      AvsAuthorizationReq(
        cardNumber: json["cardNumber"],
        expiryMonth: json["expiryMonth"],
        expiryYear: json["expiryYear"],
        cvv: json["cvv"],
        redirectUrl: json["redirectUrl"],
        requestId: json["requestId"],
        email: json["email"],
        authorization: json["authorization"] == null
            ? null
            : AvsModeAuthorization.fromJson(json["authorization"]),
      );

  Map<String, dynamic> toJson() => {
        "cardNumber": cardNumber,
        "expiryMonth": expiryMonth,
        "expiryYear": expiryYear,
        "cvv": cvv,
        "redirectUrl": redirectUrl,
        "requestId": requestId,
        "email": email,
        "authorization": authorization?.toJson(),
      };
}

class AvsModeAuthorization {
  final String? mode;
  final String? city;
  final String? address;
  final String? state;
  final String? country;
  final String? zipcode;

  AvsModeAuthorization({
    this.mode,
    this.city,
    this.address,
    this.state,
    this.country,
    this.zipcode,
  });

  AvsModeAuthorization copyWith({
    String? mode,
    String? city,
    String? address,
    String? state,
    String? country,
    String? zipcode,
  }) =>
      AvsModeAuthorization(
        mode: mode ?? this.mode,
        city: city ?? this.city,
        address: address ?? this.address,
        state: state ?? this.state,
        country: country ?? this.country,
        zipcode: zipcode ?? this.zipcode,
      );

  factory AvsModeAuthorization.fromJson(Map<String, dynamic> json) =>
      AvsModeAuthorization(
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
