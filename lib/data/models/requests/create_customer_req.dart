import 'dart:convert';

CreateCustomerAccountReq createCustomerAccountReqFromJson(String str) =>
    CreateCustomerAccountReq.fromJson(json.decode(str));

String createCustomerAccountReqToJson(CreateCustomerAccountReq data) =>
    json.encode(data.toJson());

class CreateCustomerAccountReq {
  final String? currencyCode;

  CreateCustomerAccountReq({
    this.currencyCode,
  });

  CreateCustomerAccountReq copyWith({
    String? currencyCode,
  }) =>
      CreateCustomerAccountReq(
        currencyCode: currencyCode ?? this.currencyCode,
      );

  factory CreateCustomerAccountReq.fromJson(Map<String, dynamic> json) =>
      CreateCustomerAccountReq(
        currencyCode: json["currencyCode"],
      );

  Map<String, dynamic> toJson() => {
        "currencyCode": currencyCode,
      };
}
