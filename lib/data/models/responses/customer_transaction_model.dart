import 'dart:convert';

TransactionsRes transactionsResFromJson(String str) => TransactionsRes.fromJson(json.decode(str));

String transactionsResToJson(TransactionsRes data) => json.encode(data.toJson());

class TransactionsRes {
  final String? userId;
  final String? reference;
  final String? requestId;
  final DateTime? transactionDate;
  final String? postingType;
  final String? currency;
  final int? trxAmount;
  final int? trxFee;
  final String? narration;
  final String? beneficiary;
  final String? serviceTypeName;
  final String? serviceTypeChannel;
  final String? clientChannel;

  TransactionsRes({
    this.userId,
    this.reference,
    this.requestId,
    this.transactionDate,
    this.postingType,
    this.currency,
    this.trxAmount,
    this.trxFee,
    this.narration,
    this.beneficiary,
    this.serviceTypeName,
    this.serviceTypeChannel,
    this.clientChannel,
  });

  factory TransactionsRes.fromJson(Map<String, dynamic> json) => TransactionsRes(
        userId: json["userId"],
        reference: json["reference"],
        requestId: json["requestId"],
        transactionDate:
            json["transactionDate"] == null ? null : DateTime.parse(json["transactionDate"]),
        postingType: json["postingType"],
        currency: json["currency"],
        trxAmount: json["trxAmount"],
        trxFee: json["trxFee"],
        narration: json["narration"],
        beneficiary: json["beneficiary"],
        serviceTypeName: json["serviceTypeName"],
        serviceTypeChannel: json["serviceTypeChannel"],
        clientChannel: json["clientChannel"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "reference": reference,
        "requestId": requestId,
        "transactionDate": transactionDate?.toIso8601String(),
        "postingType": postingType,
        "currency": currency,
        "trxAmount": trxAmount,
        "trxFee": trxFee,
        "narration": narration,
        "beneficiary": beneficiary,
        "serviceTypeName": serviceTypeName,
        "serviceTypeChannel": serviceTypeChannel,
        "clientChannel": clientChannel,
      };
}
