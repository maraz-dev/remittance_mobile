import 'dart:convert';

CorridorsResponse corridorsResponseFromJson(String str) =>
    CorridorsResponse.fromJson(json.decode(str));

String corridorsResponseToJson(CorridorsResponse data) => json.encode(data.toJson());

class CorridorsResponse {
  final String? name;
  final String? code;
  final Flag? flag;
  final List<SMCountry>? sourceCurrencies;
  final List<SMCountry>? destinationCountries;

  CorridorsResponse({
    this.name,
    this.code,
    this.flag,
    this.sourceCurrencies,
    this.destinationCountries,
  });

  factory CorridorsResponse.fromJson(Map<String, dynamic> json) => CorridorsResponse(
        name: json["name"],
        code: json["code"],
        flag: json["flag"] == null ? null : Flag.fromJson(json["flag"]),
        sourceCurrencies: json["sourceCurrencies"] == null
            ? []
            : List<SMCountry>.from(json["sourceCurrencies"]!.map((x) => SMCountry.fromJson(x))),
        destinationCountries: json["destinationCountries"] == null
            ? []
            : List<SMCountry>.from(json["destinationCountries"]!.map((x) => SMCountry.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "flag": flag?.toJson(),
        "sourceCurrencies": sourceCurrencies == null
            ? []
            : List<dynamic>.from(sourceCurrencies!.map((x) => x.toJson())),
        "destinationCountries": destinationCountries == null
            ? []
            : List<dynamic>.from(destinationCountries!.map((x) => x.toJson())),
      };
}

class SMCountry {
  final String? name;
  final String? code;
  final Flag? flag;
  final List<DestinationCurrency>? destinationCurrencies;
  final String? symbol;

  SMCountry({
    this.name,
    this.code,
    this.flag,
    this.destinationCurrencies,
    this.symbol,
  });

  factory SMCountry.fromJson(Map<String, dynamic> json) => SMCountry(
        name: json["name"],
        code: json["code"],
        flag: json["flag"] == null ? null : Flag.fromJson(json["flag"]),
        destinationCurrencies: json["destinationCurrencies"] == null
            ? []
            : List<DestinationCurrency>.from(
                json["destinationCurrencies"]!.map((x) => DestinationCurrency.fromJson(x))),
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "flag": flag?.toJson(),
        "destinationCurrencies": destinationCurrencies == null
            ? []
            : List<dynamic>.from(destinationCurrencies!.map((x) => x.toJson())),
        "symbol": symbol,
      };
}

class DestinationCurrency {
  final String? code;
  final String? name;
  final String? symbol;
  final Flag? flag;
  final List<RecipientType>? recipientTypes;

  DestinationCurrency({
    this.code,
    this.name,
    this.symbol,
    this.flag,
    this.recipientTypes,
  });

  factory DestinationCurrency.fromJson(Map<String, dynamic> json) => DestinationCurrency(
        code: json["code"],
        name: json["name"],
        symbol: json["symbol"],
        flag: json["flag"] == null ? null : Flag.fromJson(json["flag"]),
        recipientTypes: json["recipientTypes"] == null
            ? []
            : List<RecipientType>.from(
                json["recipientTypes"]!.map((x) => RecipientType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "symbol": symbol,
        "flag": flag?.toJson(),
        "recipientTypes": recipientTypes == null
            ? []
            : List<dynamic>.from(recipientTypes!.map((x) => x.toJson())),
      };
}

class Flag {
  final String? svg;
  final String? png;

  Flag({
    this.svg,
    this.png,
  });

  factory Flag.fromJson(Map<String, dynamic> json) => Flag(
        svg: json["svg"],
        png: json["png"],
      );

  Map<String, dynamic> toJson() => {
        "svg": svg,
        "png": png,
      };
}

class RecipientType {
  final String? name;
  final String? description;

  RecipientType({
    this.name,
    this.description,
  });

  factory RecipientType.fromJson(Map<String, dynamic> json) => RecipientType(
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
      };
}
