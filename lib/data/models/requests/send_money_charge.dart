import 'dart:convert';

SendChargeReq sendChargeReqFromJson(String str) =>
    SendChargeReq.fromJson(json.decode(str));

String sendChargeReqToJson(SendChargeReq data) => json.encode(data.toJson());

class SendChargeReq {
  final String? destinationCountryCode;
  final String? sourceCurrency;
  final String? destinationCurrency;
  final String? channel;
  final double? amount;

  SendChargeReq({
    this.destinationCountryCode,
    this.sourceCurrency,
    this.destinationCurrency,
    this.channel,
    this.amount,
  });

  SendChargeReq copyWith({
    String? destinationCountryCode,
    String? sourceCurrency,
    String? destinationCurrency,
    String? channel,
    double? amount,
  }) =>
      SendChargeReq(
        destinationCountryCode:
            destinationCountryCode ?? this.destinationCountryCode,
        sourceCurrency: sourceCurrency ?? this.sourceCurrency,
        destinationCurrency: destinationCurrency ?? this.destinationCurrency,
        channel: channel ?? this.channel,
        amount: amount ?? this.amount,
      );

  factory SendChargeReq.fromJson(Map<String, dynamic> json) => SendChargeReq(
        destinationCountryCode: json["destinationCountryCode"],
        sourceCurrency: json["sourceCurrency"],
        destinationCurrency: json["destinationCurrency"],
        channel: json["channel"],
        amount: json["amount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "destinationCountryCode": destinationCountryCode,
        "sourceCurrency": sourceCurrency,
        "destinationCurrency": destinationCurrency,
        "channel": channel,
        "amount": amount,
      };
}
