import 'dart:convert';

FundingOptionDto fundingOptionDtoFromJson(String str) =>
    FundingOptionDto.fromJson(json.decode(str));

String fundingOptionDtoToJson(FundingOptionDto data) => json.encode(data.toJson());

class FundingOptionDto {
  final String? channel;
  final List<FundingOption>? fundingOptions;

  FundingOptionDto({
    this.channel,
    this.fundingOptions,
  });

  factory FundingOptionDto.fromJson(Map<String, dynamic> json) => FundingOptionDto(
        channel: json["channel"],
        fundingOptions: json["fundingOptions"] == null
            ? []
            : List<FundingOption>.from(
                json["fundingOptions"]!.map((x) => FundingOption.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "channel": channel,
        "fundingOptions": fundingOptions == null
            ? []
            : List<dynamic>.from(fundingOptions!.map((x) => x.toJson())),
      };
}

class FundingOption {
  final int? id;
  final String? vendor;
  final String? vendorCode;
  final String? channel;
  final String? chargeRule;
  final int? cap;
  final double? minimum;
  final int? maximum;
  final double? percentage;
  final int? flat;
  final int? charge;
  final bool? isDefault;
  final bool? isBanded;
  final List<dynamic>? bands;

  FundingOption({
    this.id,
    this.vendor,
    this.vendorCode,
    this.channel,
    this.chargeRule,
    this.cap,
    this.minimum,
    this.maximum,
    this.percentage,
    this.flat,
    this.charge,
    this.isDefault,
    this.isBanded,
    this.bands,
  });

  factory FundingOption.fromJson(Map<String, dynamic> json) => FundingOption(
        id: json["id"],
        vendor: json["vendor"],
        vendorCode: json["vendorCode"],
        channel: json["channel"],
        chargeRule: json["chargeRule"],
        cap: json["cap"],
        minimum: json["minimum"]?.toDouble(),
        maximum: json["maximum"],
        percentage: json["percentage"]?.toDouble(),
        flat: json["flat"],
        charge: json["charge"],
        isDefault: json["isDefault"],
        isBanded: json["isBanded"],
        bands: json["bands"] == null ? [] : List<dynamic>.from(json["bands"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor": vendor,
        "vendorCode": vendorCode,
        "channel": channel,
        "chargeRule": chargeRule,
        "cap": cap,
        "minimum": minimum,
        "maximum": maximum,
        "percentage": percentage,
        "flat": flat,
        "charge": charge,
        "isDefault": isDefault,
        "isBanded": isBanded,
        "bands": bands == null ? [] : List<dynamic>.from(bands!.map((x) => x)),
      };
}
