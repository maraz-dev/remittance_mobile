import 'dart:convert';

SendChargeResponse sendChargeResponseFromJson(String str) =>
    SendChargeResponse.fromJson(json.decode(str));

String sendChargeResponseToJson(SendChargeResponse data) => json.encode(data.toJson());

class SendChargeResponse {
  final num? rate;
  final num? feeInDestinationCurrency;
  final num? feeInSourceCurrency;
  final num? amountConverted;
  final num? destinationAmount;
  final dynamic feesPerChannel;

  SendChargeResponse({
    this.rate,
    this.feeInDestinationCurrency,
    this.feeInSourceCurrency,
    this.amountConverted,
    this.destinationAmount,
    this.feesPerChannel,
  });

  factory SendChargeResponse.fromJson(Map<String, dynamic> json) => SendChargeResponse(
        rate: json["rate"],
        feeInDestinationCurrency: json["feeInDestinationCurrency"]?.toDouble(),
        feeInSourceCurrency: json["feeInSourceCurrency"],
        amountConverted: json["amountConverted"],
        destinationAmount: json["destinationAmount"],
        feesPerChannel: json["feesPerChannel"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "feeInDestinationCurrency": feeInDestinationCurrency,
        "feeInSourceCurrency": feeInSourceCurrency,
        "amountConverted": amountConverted,
        "destinationAmount": destinationAmount,
        "feesPerChannel": feesPerChannel,
      };
}
