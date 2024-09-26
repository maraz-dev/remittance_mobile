import 'dart:convert';

VerifyFundingTransxReq verifyTransxReqFromJson(String str) =>
    VerifyFundingTransxReq.fromJson(json.decode(str));

String verifyTransxReqToJson(VerifyFundingTransxReq data) =>
    json.encode(data.toJson());

class VerifyFundingTransxReq {
  final int? flwTransactionId;
  final String? requestId;

  VerifyFundingTransxReq({
    this.flwTransactionId,
    this.requestId,
  });

  VerifyFundingTransxReq copyWith({
    int? flwTransactionId,
    String? requestId,
  }) =>
      VerifyFundingTransxReq(
        flwTransactionId: flwTransactionId ?? this.flwTransactionId,
        requestId: requestId ?? this.requestId,
      );

  factory VerifyFundingTransxReq.fromJson(Map<String, dynamic> json) =>
      VerifyFundingTransxReq(
        flwTransactionId: json["flwTransactionId"] ?? 0,
        requestId: json["requestId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "flwTransactionId": flwTransactionId,
        "requestId": requestId,
      };
}
