import 'dart:convert';

AccountModel accountModelFromJson(String str) =>
    AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  final String? userId;
  final String? partnerCode;
  final dynamic businessCode;
  final String? type;
  final String? accountName;
  final String? accountNumber;
  final double? balance;
  final String? currency;
  final String? status;
  final String? countryCode;
  final String? tier;
  final CurrencyResponse? currencyResponse;
  final String? id;
  final bool? isActive;
  final bool? isDeleted;
  final String? createdBy;
  final DateTime? dateCreated;
  final DateTime? dateModified;
  final dynamic modifiedBy;

  AccountModel({
    this.userId,
    this.partnerCode,
    this.businessCode,
    this.type,
    this.accountName,
    this.accountNumber,
    this.balance,
    this.currency,
    this.status,
    this.countryCode,
    this.tier,
    this.currencyResponse,
    this.id,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.dateCreated,
    this.dateModified,
    this.modifiedBy,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        userId: json["userId"],
        partnerCode: json["partnerCode"],
        businessCode: json["businessCode"],
        type: json["type"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        balance: json["balance"].toDouble(),
        currency: json["currency"],
        status: json["status"],
        countryCode: json["countryCode"],
        tier: json["tier"],
        currencyResponse: json["currencyResponse"] == null
            ? null
            : CurrencyResponse.fromJson(json["currencyResponse"]),
        id: json["id"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        dateCreated: json["dateCreated"] == null
            ? null
            : DateTime.parse(json["dateCreated"]),
        dateModified: json["dateModified"] == null
            ? null
            : DateTime.parse(json["dateModified"]),
        modifiedBy: json["modifiedBy"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "partnerCode": partnerCode,
        "businessCode": businessCode,
        "type": type,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "balance": balance,
        "currency": currency,
        "status": status,
        "countryCode": countryCode,
        "tier": tier,
        "currencyResponse": currencyResponse?.toJson(),
        "id": id,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "dateCreated": dateCreated?.toIso8601String(),
        "dateModified": dateModified?.toIso8601String(),
        "modifiedBy": modifiedBy,
      };
}

class CurrencyResponse {
  final String? currencyCode;
  final String? currencyName;
  final String? currencySymbol;
  final String? flagPng;
  final String? flagSvg;

  CurrencyResponse({
    this.currencyCode,
    this.currencyName,
    this.currencySymbol,
    this.flagPng,
    this.flagSvg,
  });

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) =>
      CurrencyResponse(
        currencyCode: json["currencyCode"],
        currencyName: json["currencyName"],
        currencySymbol: json["currencySymbol"],
        flagPng: json["flagPng"],
        flagSvg: json["flagSvg"],
      );

  Map<String, dynamic> toJson() => {
        "currencyCode": currencyCode,
        "currencyName": currencyName,
        "currencySymbol": currencySymbol,
        "flagPng": flagPng,
        "flagSvg": flagSvg,
      };
}
