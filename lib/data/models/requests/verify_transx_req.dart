import 'dart:convert';

VerifyTransxReq verifyTransxReqFromJson(String str) =>
    VerifyTransxReq.fromJson(json.decode(str));

String verifyTransxReqToJson(VerifyTransxReq data) =>
    json.encode(data.toJson());

class VerifyTransxReq {
  final int? flwTransactionId;
  final String? requestId;

  VerifyTransxReq({
    this.flwTransactionId,
    this.requestId,
  });

  VerifyTransxReq copyWith({
    int? flwTransactionId,
    String? requestId,
  }) =>
      VerifyTransxReq(
        flwTransactionId: flwTransactionId ?? this.flwTransactionId,
        requestId: requestId ?? this.requestId,
      );

  factory VerifyTransxReq.fromJson(Map<String, dynamic> json) =>
      VerifyTransxReq(
        flwTransactionId: json["flwTransactionId"],
        requestId: json["requestId"],
      );

  Map<String, dynamic> toJson() => {
        "flwTransactionId": flwTransactionId,
        "requestId": requestId,
      };
}
