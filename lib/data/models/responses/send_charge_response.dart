class SendChargeResponse {
  final Rate? rate;
  final Charge? charge;
  final Commission? commission;
  final double? amountConverted;
  final double? destinationAmount;

  SendChargeResponse({
    this.rate,
    this.charge,
    this.commission,
    this.amountConverted,
    this.destinationAmount,
  });

  factory SendChargeResponse.fromJson(Map<String, dynamic> json) =>
      SendChargeResponse(
        rate: json["rate"] == null ? null : Rate.fromJson(json["rate"]),
        charge: json["charge"] == null ? null : Charge.fromJson(json["charge"]),
        commission: json["commission"] == null
            ? null
            : Commission.fromJson(json["commission"]),
        amountConverted: json["amountConverted"]?.toDouble(),
        destinationAmount: json["destinationAmount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "rate": rate?.toJson(),
        "charge": charge?.toJson(),
        "commission": commission?.toJson(),
        "amountConverted": amountConverted,
        "destinationAmount": destinationAmount,
      };
}

class Charge {
  final double? vendorFee;
  final double? partnerFee;
  final double? partnerSplitFee;
  final double? customerSplitFee;
  final double? platformFee;

  Charge({
    this.vendorFee,
    this.partnerFee,
    this.partnerSplitFee,
    this.customerSplitFee,
    this.platformFee,
  });

  factory Charge.fromJson(Map<String, dynamic> json) => Charge(
        vendorFee: json["vendorFee"]?.toDouble(),
        partnerFee: json["partnerFee"]?.toDouble(),
        partnerSplitFee: json["partnerSplitFee"]?.toDouble(),
        customerSplitFee: json["customerSplitFee"]?.toDouble(),
        platformFee: json["platformFee"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "vendorFee": vendorFee,
        "partnerFee": partnerFee,
        "partnerSplitFee": partnerSplitFee,
        "customerSplitFee": customerSplitFee,
        "platformFee": platformFee,
      };
}

class Commission {
  final RateCommission? rateCommission;
  final FeeCommission? feeCommission;

  Commission({
    this.rateCommission,
    this.feeCommission,
  });

  factory Commission.fromJson(Map<String, dynamic> json) => Commission(
        rateCommission: json["rateCommission"] == null
            ? null
            : RateCommission.fromJson(json["rateCommission"]),
        feeCommission: json["feeCommission"] == null
            ? null
            : FeeCommission.fromJson(json["feeCommission"]),
      );

  Map<String, dynamic> toJson() => {
        "rateCommission": rateCommission?.toJson(),
        "feeCommission": feeCommission?.toJson(),
      };
}

class FeeCommission {
  final double? partnerFeeCommission;
  final double? platformFeeCommission;
  final double? vendorFeeCommission;

  FeeCommission({
    this.partnerFeeCommission,
    this.platformFeeCommission,
    this.vendorFeeCommission,
  });

  factory FeeCommission.fromJson(Map<String, dynamic> json) => FeeCommission(
        partnerFeeCommission: json["partnerFeeCommission"]?.toDouble(),
        platformFeeCommission: json["platformFeeCommission"]?.toDouble(),
        vendorFeeCommission: json["vendorFeeCommission"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "partnerFeeCommission": partnerFeeCommission,
        "platformFeeCommission": platformFeeCommission,
        "vendorFeeCommission": vendorFeeCommission,
      };
}

class RateCommission {
  final double? partnerRateCommission;
  final double? platformRateCommission;
  final double? vendorRateCommission;

  RateCommission({
    this.partnerRateCommission,
    this.platformRateCommission,
    this.vendorRateCommission,
  });

  factory RateCommission.fromJson(Map<String, dynamic> json) => RateCommission(
        partnerRateCommission: json["partnerRateCommission"]?.toDouble(),
        platformRateCommission: json["platformRateCommission"]?.toDouble(),
        vendorRateCommission: json["vendorRateCommission"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "partnerRateCommission": partnerRateCommission,
        "platformRateCommission": platformRateCommission,
        "vendorRateCommission": vendorRateCommission,
      };
}

class Rate {
  final double? exchangeRate;
  final double? platformRate;
  final double? vendorRate;
  final double? partnerRate;
  final double? partnerMarkupMargin;
  final double? platformMarkupMargin;
  final double? partnerMarkupInterest;
  final double? platformMarkupInterest;
  final double? amountConverted;
  final double? recipientAmount;

  Rate({
    this.exchangeRate,
    this.platformRate,
    this.vendorRate,
    this.partnerRate,
    this.partnerMarkupMargin,
    this.platformMarkupMargin,
    this.partnerMarkupInterest,
    this.platformMarkupInterest,
    this.amountConverted,
    this.recipientAmount,
  });

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        exchangeRate: json["exchangeRate"]?.toDouble(),
        platformRate: json["platformRate"]?.toDouble(),
        vendorRate: json["vendorRate"]?.toDouble(),
        partnerRate: json["partnerRate"]?.toDouble(),
        partnerMarkupMargin: json["partnerMarkupMargin"]?.toDouble(),
        platformMarkupMargin: json["platformMarkupMargin"]?.toDouble(),
        partnerMarkupInterest: json["partnerMarkupInterest"]?.toDouble(),
        platformMarkupInterest: json["platformMarkupInterest"]?.toDouble(),
        amountConverted: json["amountConverted"]?.toDouble(),
        recipientAmount: json["recipientAmount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "exchangeRate": exchangeRate,
        "platformRate": platformRate,
        "vendorRate": vendorRate,
        "partnerRate": partnerRate,
        "partnerMarkupMargin": partnerMarkupMargin,
        "platformMarkupMargin": platformMarkupMargin,
        "partnerMarkupInterest": partnerMarkupInterest,
        "platformMarkupInterest": platformMarkupInterest,
        "amountConverted": amountConverted,
        "recipientAmount": recipientAmount,
      };
}
