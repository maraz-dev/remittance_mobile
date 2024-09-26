import 'dart:convert';

AccountModel accountModelFromJson(String str) =>
    AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  final String? userId;
  final String? partnerCode;
  final String? businessCode;
  final String? type;
  final String? accountName;
  final String? accountNumber;
  final double? balance;
  final String? status;
  final String? tier;
  final String? currencyCode;
  final String? currencyName;
  final String? currencySymbol;
  final String? countryCode;
  final String? flagPng;
  final String? flagSvg;

  AccountModel({
    this.userId,
    this.partnerCode,
    this.businessCode,
    this.type,
    this.accountName,
    this.accountNumber,
    this.balance,
    this.status,
    this.tier,
    this.currencyCode,
    this.currencyName,
    this.currencySymbol,
    this.countryCode,
    this.flagPng,
    this.flagSvg,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        userId: json["userId"],
        partnerCode: json["partnerCode"],
        businessCode: json["businessCode"],
        type: json["type"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        balance: json["balance"].toDouble(),
        status: json["status"],
        tier: json["tier"],
        currencyCode: json["currencyCode"],
        currencyName: json["currencyName"],
        currencySymbol: json["currencySymbol"],
        countryCode: json["countryCode"],
        flagPng: json["flagPng"],
        flagSvg: json["flagSvg"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "partnerCode": partnerCode,
        "businessCode": businessCode,
        "type": type,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "balance": balance,
        "status": status,
        "tier": tier,
        "currencyCode": currencyCode,
        "currencyName": currencyName,
        "currencySymbol": currencySymbol,
        "countryCode": countryCode,
        "flagPng": flagPng,
        "flagSvg": flagSvg,
      };
}
