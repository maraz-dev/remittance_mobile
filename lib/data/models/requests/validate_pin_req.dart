import 'dart:convert';

ValidatePinReq validatePinReqFromJson(String str) =>
    ValidatePinReq.fromJson(json.decode(str));

String validatePinReqToJson(ValidatePinReq data) => json.encode(data.toJson());

class ValidatePinReq {
  String? emailAddress;
  String? pin;

  ValidatePinReq({
    this.emailAddress,
    this.pin,
  });

  ValidatePinReq copyWith({
    String? emailAddress,
    String? pin,
  }) =>
      ValidatePinReq(
        emailAddress: emailAddress ?? this.emailAddress,
        pin: pin ?? this.pin,
      );

  factory ValidatePinReq.fromJson(Map<String, dynamic> json) => ValidatePinReq(
        emailAddress: json["emailAddress"],
        pin: json["pin"],
      );

  Map<String, dynamic> toJson() => {
        "emailAddress": emailAddress,
        "pin": pin,
      };
}
