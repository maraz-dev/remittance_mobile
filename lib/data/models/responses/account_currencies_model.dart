import 'dart:convert';

AccountCurrencies accountCurrenciesFromJson(String str) =>
    AccountCurrencies.fromJson(json.decode(str));

String accountCurrenciesToJson(AccountCurrencies data) =>
    json.encode(data.toJson());

class AccountCurrencies {
  final String? currencyCode;
  final String? countryCode;
  final String? currencyName;
  final String? currencySymbol;
  final String? flagPng;
  final String? flagSvg;

  AccountCurrencies({
    this.currencyCode,
    this.countryCode,
    this.currencyName,
    this.currencySymbol,
    this.flagPng,
    this.flagSvg,
  });

  factory AccountCurrencies.fromJson(Map<String, dynamic> json) =>
      AccountCurrencies(
        currencyCode: json["currencyCode"],
        countryCode: json["countryCode"],
        currencyName: json["currencyName"],
        currencySymbol: json["currencySymbol"],
        flagPng: json["flagPng"],
        flagSvg: json["flagSvg"],
      );

  Map<String, dynamic> toJson() => {
        "currencyCode": currencyCode,
        "countryCode": countryCode,
        "currencyName": currencyName,
        "currencySymbol": currencySymbol,
        "flagPng": flagPng,
        "flagSvg": flagSvg,
      };
}
