import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  final String? userId;
  final String? accountNumber;
  final String? reference;
  final String? requestId;
  final DateTime? transactionDate;
  final String? postingType;
  final String? sourceCountryCode;
  final String? sourceCurrency;
  final Currency? currency;
  final double? trxAmount;
  final double? trxFee;
  final String? narration;
  final String? beneficiary;
  final String? serviceTypeName;
  final String? serviceTypeChannel;
  final String? clientChannel;
  final String? status;

  TransactionModel({
    this.userId,
    this.accountNumber,
    this.reference,
    this.requestId,
    this.transactionDate,
    this.postingType,
    this.sourceCountryCode,
    this.sourceCurrency,
    this.currency,
    this.trxAmount,
    this.trxFee,
    this.narration,
    this.beneficiary,
    this.serviceTypeName,
    this.serviceTypeChannel,
    this.clientChannel,
    this.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        userId: json["userId"],
        accountNumber: json["accountNumber"],
        reference: json["reference"],
        requestId: json["requestId"],
        transactionDate:
            json["transactionDate"] == null ? null : DateTime.parse(json["transactionDate"]),
        postingType: json["postingType"],
        sourceCountryCode: json["sourceCountryCode"],
        sourceCurrency: json["sourceCurrency"],
        currency: json["currency"] == null ? null : Currency.fromJson(json["currency"]),
        trxAmount: json["trxAmount"]?.toDouble(),
        trxFee: json["trxFee"]?.toDouble(),
        narration: json["narration"],
        beneficiary: json["beneficiary"],
        serviceTypeName: json["serviceTypeName"],
        serviceTypeChannel: json["serviceTypeChannel"],
        clientChannel: json["clientChannel"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "accountNumber": accountNumber,
        "reference": reference,
        "requestId": requestId,
        "transactionDate": transactionDate?.toIso8601String(),
        "postingType": postingType,
        "sourceCountryCode": sourceCountryCode,
        "sourceCurrency": sourceCurrency,
        "currency": currency?.toJson(),
        "trxAmount": trxAmount,
        "trxFee": trxFee,
        "narration": narration,
        "beneficiary": beneficiary,
        "serviceTypeName": serviceTypeName,
        "serviceTypeChannel": serviceTypeChannel,
        "clientChannel": clientChannel,
        "status": status,
      };
}

class Currency {
  final String? name;
  final String? symbol;
  final Flag? flag;

  Currency({
    this.name,
    this.symbol,
    this.flag,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        symbol: json["symbol"],
        flag: json["flag"] == null ? null : Flag.fromJson(json["flag"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
        "flag": flag?.toJson(),
      };
}

class Flag {
  final String? svg;
  final String? png;

  Flag({
    this.svg,
    this.png,
  });

  factory Flag.fromJson(Map<String, dynamic> json) => Flag(
        svg: json["svg"],
        png: json["png"],
      );

  Map<String, dynamic> toJson() => {
        "svg": svg,
        "png": png,
      };
}
