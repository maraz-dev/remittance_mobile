class NewCountryModel {
  String? name;
  String? code;
  String? description;
  String? flagPng;
  String? flagSvg;
  String? continent;
  String? currencyCode;
  String? currencyName;
  String? currencySymbol;
  dynamic phoneCode;
  dynamic phoneNumberLength;
  dynamic samplePhoneNumber;

  NewCountryModel({
    this.name,
    this.code,
    this.description,
    this.flagPng,
    this.flagSvg,
    this.continent,
    this.currencyCode,
    this.currencyName,
    this.currencySymbol,
    this.phoneCode,
    this.phoneNumberLength,
    this.samplePhoneNumber,
  });

  factory NewCountryModel.fromJson(Map<String, dynamic> json) =>
      NewCountryModel(
        name: json["name"],
        code: json["code"],
        description: json["description"],
        flagPng: json["flagPng"],
        flagSvg: json["flagSvg"],
        continent: json["continent"],
        currencyCode: json["currencyCode"],
        currencyName: json["currencyName"],
        currencySymbol: json["currencySymbol"],
        phoneCode: json["phoneCode"],
        phoneNumberLength: json["phoneNumberLength"],
        samplePhoneNumber: json["samplePhoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "description": description,
        "flagPng": flagPng,
        "flagSvg": flagSvg,
        "continent": continent,
        "currencyCode": currencyCode,
        "currencyName": currencyName,
        "currencySymbol": currencySymbol,
        "phoneCode": phoneCode,
        "phoneNumberLength": phoneNumberLength,
        "samplePhoneNumber": samplePhoneNumber,
      };
}
