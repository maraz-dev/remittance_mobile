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
  final String? accountNumber;
  final String? reference;
  final String? requestId;
  final DateTime? transactionDate;
  final String? postingType;
  final String? sourceCountryCode;
  final String? sourceCurrency;
  final Currency? currency;
  final num? trxAmount;
  final num? trxFee;
  final String? narration;
  final String? beneficiary;
  final String? serviceTypeName;
  final String? serviceTypeChannel;
  final String? clientChannel;
  final String? status;

  TransxDetail({
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

  factory TransxDetail.fromJson(Map<String, dynamic> json) => TransxDetail(
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
        trxAmount: json["trxAmount"],
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
  final String? shortCode;
  final Flag? flag;

  Currency({
    this.name,
    this.symbol,
    this.shortCode,
    this.flag,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        symbol: json["symbol"],
        shortCode: json["shortCode"],
        flag: json["flag"] == null ? null : Flag.fromJson(json["flag"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
        "shortCode": shortCode,
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
