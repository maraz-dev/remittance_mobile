import 'dart:convert';

TransactionDetailRes transactionDetailResFromJson(String str) =>
    TransactionDetailRes.fromJson(json.decode(str));

String transactionDetailResToJson(TransactionDetailRes data) => json.encode(data.toJson());

class TransactionDetailRes {
  final Detail? detail;
  final List<Update>? updates;

  TransactionDetailRes({
    this.detail,
    this.updates,
  });

  factory TransactionDetailRes.fromJson(Map<String, dynamic> json) => TransactionDetailRes(
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
        updates: json["updates"] == null
            ? []
            : List<Update>.from(json["updates"]!.map((x) => Update.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "detail": detail?.toJson(),
        "updates": updates == null ? [] : List<dynamic>.from(updates!.map((x) => x.toJson())),
      };
}

class Detail {
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

  Detail({
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

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
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

class Update {
  final String? status;
  final String? comment;
  final DateTime? dateCreated;

  Update({
    this.status,
    this.comment,
    this.dateCreated,
  });

  factory Update.fromJson(Map<String, dynamic> json) => Update(
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
