import 'dart:convert';

SendMoneyResponse sendMoneyResponseFromJson(String str) =>
    SendMoneyResponse.fromJson(json.decode(str));

String sendMoneyResponseToJson(SendMoneyResponse data) => json.encode(data.toJson());

class SendMoneyResponse {
  final String? requestId;
  final String? reference;

  SendMoneyResponse({this.requestId, this.reference});

  factory SendMoneyResponse.fromJson(Map<String, dynamic> json) => SendMoneyResponse(
        requestId: json["requestId"],
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "requestId": requestId,
        "reference": reference,
      };
}
