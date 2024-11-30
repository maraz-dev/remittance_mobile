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
  final FeesPerChannel? feesPerChannel;

  SendChargeResponse({
    this.rate,
    this.feeInDestinationCurrency,
    this.feeInSourceCurrency,
    this.amountConverted,
    this.destinationAmount,
    this.feesPerChannel,
  });

  SendChargeResponse copyWith({
    num? rate,
    num? feeInDestinationCurrency,
    num? feeInSourceCurrency,
    num? amountConverted,
    num? destinationAmount,
    FeesPerChannel? feesPerChannel,
  }) =>
      SendChargeResponse(
        rate: rate ?? this.rate,
        feeInDestinationCurrency: feeInDestinationCurrency ?? this.feeInDestinationCurrency,
        feeInSourceCurrency: feeInSourceCurrency ?? this.feeInSourceCurrency,
        amountConverted: amountConverted ?? this.amountConverted,
        destinationAmount: destinationAmount ?? this.destinationAmount,
        feesPerChannel: feesPerChannel ?? this.feesPerChannel,
      );

  factory SendChargeResponse.fromJson(Map<String, dynamic> json) => SendChargeResponse(
        rate: json["rate"]?.toDouble(),
        feeInDestinationCurrency: json["feeInDestinationCurrency"],
        feeInSourceCurrency: json["feeInSourceCurrency"],
        amountConverted: json["amountConverted"],
        destinationAmount: json["destinationAmount"],
        feesPerChannel:
            json["feesPerChannel"] == null ? null : FeesPerChannel.fromJson(json["feesPerChannel"]),
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "feeInDestinationCurrency": feeInDestinationCurrency,
        "feeInSourceCurrency": feeInSourceCurrency,
        "amountConverted": amountConverted,
        "destinationAmount": destinationAmount,
        "feesPerChannel": feesPerChannel?.toJson(),
      };
}

class FeesPerChannel {
  final Bank? bank;
  final Bank? mobileMoney;
  final Bank? cashPickup;

  FeesPerChannel({
    this.bank,
    this.mobileMoney,
    this.cashPickup,
  });

  FeesPerChannel copyWith({Bank? bank, Bank? mobileMoney, Bank? cashPickup}) => FeesPerChannel(
        bank: bank ?? this.bank,
        mobileMoney: mobileMoney ?? this.mobileMoney,
      );

  factory FeesPerChannel.fromJson(Map<String, dynamic> json) => FeesPerChannel(
        bank: json["Bank"] == null ? null : Bank.fromJson(json["Bank"]),
        mobileMoney: json["MobileMoney"] == null ? null : Bank.fromJson(json["MobileMoney"]),
        cashPickup: json["CashPickup"] == null ? null : Bank.fromJson(json["CashPickup"]),
      );

  Map<String, dynamic> toJson() => {
        "Bank": bank?.toJson(),
        "MobileMoney": mobileMoney?.toJson(),
        "CashPickup": cashPickup?.toJson(),
      };
}

class Bank {
  final num? minimumPayoutAmount;
  final num? maximumPayoutAmount;
  final num? feeInDestinationCurrency;
  final num? feeInSourceCurrency;

  Bank({
    this.minimumPayoutAmount,
    this.maximumPayoutAmount,
    this.feeInDestinationCurrency,
    this.feeInSourceCurrency,
  });

  Bank copyWith({
    num? minimumPayoutAmount,
    num? maximumPayoutAmount,
    num? feeInDestinationCurrency,
    num? feeInSourceCurrency,
  }) =>
      Bank(
        minimumPayoutAmount: minimumPayoutAmount ?? this.minimumPayoutAmount,
        maximumPayoutAmount: maximumPayoutAmount ?? this.maximumPayoutAmount,
        feeInDestinationCurrency: feeInDestinationCurrency ?? this.feeInDestinationCurrency,
        feeInSourceCurrency: feeInSourceCurrency ?? this.feeInSourceCurrency,
      );

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        minimumPayoutAmount: json["minimumPayoutAmount"],
        maximumPayoutAmount: json["maximumPayoutAmount"]?.toDouble(),
        feeInDestinationCurrency: json["feeInDestinationCurrency"],
        feeInSourceCurrency: json["feeInSourceCurrency"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "minimumPayoutAmount": minimumPayoutAmount,
        "maximumPayoutAmount": maximumPayoutAmount,
        "feeInDestinationCurrency": feeInDestinationCurrency,
        "feeInSourceCurrency": feeInSourceCurrency,
      };
}
