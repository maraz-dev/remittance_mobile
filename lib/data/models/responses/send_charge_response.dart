import 'dart:convert';

SendChargeResponse sendChargeResponseFromJson(String str) =>
    SendChargeResponse.fromJson(json.decode(str));

String sendChargeResponseToJson(SendChargeResponse data) => json.encode(data.toJson());

class SendChargeResponse {
  final num? rate;
  final num? fee;
  final num? amountConverted;
  final num? destinationAmount;
  final dynamic feesPerChannel;

  SendChargeResponse({
    this.rate,
    this.fee,
    this.amountConverted,
    this.destinationAmount,
    this.feesPerChannel,
  });

  factory SendChargeResponse.fromJson(Map<String, dynamic> json) => SendChargeResponse(
        rate: json["rate"],
        fee: json["fee"],
        amountConverted: json["amountConverted"],
        destinationAmount: json["destinationAmount"],
        feesPerChannel: json["feesPerChannel"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "fee": fee,
        "amountConverted": amountConverted,
        "destinationAmount": destinationAmount,
        "feesPerChannel": feesPerChannel,
      };
}
