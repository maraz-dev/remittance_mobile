import 'dart:convert';

AccountModel accountModelFromJson(String str) =>
    AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  final String? createdBy;
  final DateTime? dateCreated;
  final DateTime? dateModified;
  final String? modifiedBy;
  final String? id;
  final bool? isActive;
  final bool? isDeleted;
  final String? userId;
  final String? partnerCode;
  final String? businessCode;
  final String? type;
  final String? accountName;
  final String? accountNumber;
  final double? balance;
  final String? currency;
  final String? status;
  final String? countryCode;
  final String? tier;

  AccountModel({
    this.createdBy,
    this.dateCreated,
    this.dateModified,
    this.modifiedBy,
    this.id,
    this.isActive,
    this.isDeleted,
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
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        createdBy: json["createdBy"],
        dateCreated: json["dateCreated"] == null
            ? null
            : DateTime.parse(json["dateCreated"]),
        dateModified: json["dateModified"] == null
            ? null
            : DateTime.parse(json["dateModified"]),
        modifiedBy: json["modifiedBy"],
        id: json["id"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
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
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "dateCreated": dateCreated?.toIso8601String(),
        "dateModified": dateModified?.toIso8601String(),
        "modifiedBy": modifiedBy,
        "id": id,
        "isActive": isActive,
        "isDeleted": isDeleted,
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
      };
}
