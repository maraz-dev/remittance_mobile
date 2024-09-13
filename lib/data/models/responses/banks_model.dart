import 'dart:convert';

BanksModel banksModelFromJson(String str) =>
    BanksModel.fromJson(json.decode(str));

String banksModelToJson(BanksModel data) => json.encode(data.toJson());

class BanksModel {
  final int? id;
  final String? code;
  final String? bankName;
  final String? countryCode;
  final String? type;
  final dynamic regulatorCode;
  final dynamic swiftCode;
  final dynamic bic;
  final dynamic isoCode;
  final dynamic description;

  BanksModel({
    this.id,
    this.code,
    this.bankName,
    this.countryCode,
    this.type,
    this.regulatorCode,
    this.swiftCode,
    this.bic,
    this.isoCode,
    this.description,
  });

  factory BanksModel.fromJson(Map<String, dynamic> json) => BanksModel(
        id: json["id"],
        code: json["code"],
        bankName: json["bankName"],
        countryCode: json["countryCode"],
        type: json["type"],
        regulatorCode: json["regulatorCode"],
        swiftCode: json["swiftCode"],
        bic: json["bic"],
        isoCode: json["isoCode"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "bankName": bankName,
        "countryCode": countryCode,
        "type": type,
        "regulatorCode": regulatorCode,
        "swiftCode": swiftCode,
        "bic": bic,
        "isoCode": isoCode,
        "description": description,
      };
}
