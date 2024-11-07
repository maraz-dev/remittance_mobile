import 'dart:convert';

SendMoneyResponse sendMoneyResponseFromJson(String str) =>
    SendMoneyResponse.fromJson(json.decode(str));

String sendMoneyResponseToJson(SendMoneyResponse data) => json.encode(data.toJson());

class SendMoneyResponse {
  final String? requestId;

  SendMoneyResponse({
    this.requestId,
  });

  factory SendMoneyResponse.fromJson(Map<String, dynamic> json) => SendMoneyResponse(
        requestId: json["requestId"],
      );

  Map<String, dynamic> toJson() => {
        "requestId": requestId,
      };
}
