import 'dart:convert';

SetPinReq setPinReqFromJson(String str) => SetPinReq.fromJson(json.decode(str));

String setPinReqToJson(SetPinReq data) => json.encode(data.toJson());

class SetPinReq {
  String? emailAddress;
  String? pin;
  String? confirmPin;

  SetPinReq({
    this.emailAddress,
    this.pin,
    this.confirmPin,
  });

  SetPinReq copyWith({
    String? emailAddress,
    String? pin,
    String? confirmPin,
  }) =>
      SetPinReq(
        emailAddress: emailAddress ?? this.emailAddress,
        pin: pin ?? this.pin,
        confirmPin: confirmPin ?? this.confirmPin,
      );

  factory SetPinReq.fromJson(Map<String, dynamic> json) => SetPinReq(
        emailAddress: json["emailAddress"],
        pin: json["pin"],
        confirmPin: json["confirmPin"],
      );

  Map<String, dynamic> toJson() => {
        "emailAddress": emailAddress,
        "pin": pin,
        "confirmPin": confirmPin,
      };
}
