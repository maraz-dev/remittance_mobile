import 'dart:convert';

ValidateAccountNumberReq validateAccountNumberReqFromJson(String str) =>
    ValidateAccountNumberReq.fromJson(json.decode(str));

String validateAccountNumberReqToJson(ValidateAccountNumberReq data) => json.encode(data.toJson());

class ValidateAccountNumberReq {
  final String? bankCode;
  final String? accountNumber;

  ValidateAccountNumberReq({
    this.bankCode,
    this.accountNumber,
  });

  ValidateAccountNumberReq copyWith({
    String? bankCode,
    String? accountNumber,
  }) =>
      ValidateAccountNumberReq(
        bankCode: bankCode ?? this.bankCode,
        accountNumber: accountNumber ?? this.accountNumber,
      );

  factory ValidateAccountNumberReq.fromJson(Map<String, dynamic> json) => ValidateAccountNumberReq(
        bankCode: json["bankCode"],
        accountNumber: json["accountNumber"],
      );

  Map<String, dynamic> toJson() => {
        "bankCode": bankCode,
        "accountNumber": accountNumber,
      };
}
