import 'dart:convert';

CreateCustomerAccountReq createCustomerAccountReqFromJson(String str) =>
    CreateCustomerAccountReq.fromJson(json.decode(str));

String createCustomerAccountReqToJson(CreateCustomerAccountReq data) =>
    json.encode(data.toJson());

class CreateCustomerAccountReq {
  final String? currencyCode;
  final String? countryCode;

  CreateCustomerAccountReq({
    this.currencyCode,
    this.countryCode,
  });

  CreateCustomerAccountReq copyWith({
    String? currencyCode,
    String? countryCode,
  }) =>
      CreateCustomerAccountReq(
        currencyCode: currencyCode ?? this.currencyCode,
        countryCode: countryCode ?? this.countryCode,
      );

  factory CreateCustomerAccountReq.fromJson(Map<String, dynamic> json) =>
      CreateCustomerAccountReq(
        currencyCode: json["currencyCode"],
        countryCode: json["countryCode"],
      );

  Map<String, dynamic> toJson() => {
        "currencyCode": currencyCode,
        "countryCode": countryCode,
      };
}
