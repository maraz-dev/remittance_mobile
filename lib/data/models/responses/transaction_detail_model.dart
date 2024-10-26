import 'dart:convert';

TransactionDetailRes transactionDetailResFromJson(String str) =>
    TransactionDetailRes.fromJson(json.decode(str));

String transactionDetailResToJson(TransactionDetailRes data) => json.encode(data.toJson());

class TransactionDetailRes {
  final TransxDetail? detail;
  final List<TransxUpdate>? updates;

  TransactionDetailRes({
    this.detail,
    this.updates,
  });

  factory TransactionDetailRes.fromJson(Map<String, dynamic> json) => TransactionDetailRes(
        detail: json["detail"] == null ? null : TransxDetail.fromJson(json["detail"]),
        updates: json["updates"] == null
            ? []
            : List<TransxUpdate>.from(json["updates"]!.map((x) => TransxUpdate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "detail": detail?.toJson(),
        "updates": updates == null ? [] : List<dynamic>.from(updates!.map((x) => x.toJson())),
      };
}

class TransxDetail {
  final String? userId;
  final String? reference;
  final String? requestId;
  final DateTime? transactionDate;
  final String? postingType;
  final String? currency;
  final num? trxAmount;
  final num? trxFee;
  final String? narration;
  final String? beneficiary;
  final String? serviceTypeName;
  final String? serviceTypeChannel;
  final String? clientChannel;

  TransxDetail({
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

  factory TransxDetail.fromJson(Map<String, dynamic> json) => TransxDetail(
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

class TransxUpdate {
  final String? status;
  final String? comment;
  final DateTime? dateCreated;

  TransxUpdate({
    this.status,
    this.comment,
    this.dateCreated,
  });

  factory TransxUpdate.fromJson(Map<String, dynamic> json) => TransxUpdate(
        status: json["status"],
        comment: json["comment"],
        dateCreated: json["dateCreated"] == null ? null : DateTime.parse(json["dateCreated"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "comment": comment,
        "dateCreated": dateCreated?.toIso8601String(),
      };
}
