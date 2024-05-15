class CountryModel {
  String? name;
  String? flag;
  String? code;
  String? dialCode;

  CountryModel({
    this.name,
    this.flag,
    this.code,
    this.dialCode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        name: json["name"],
        flag: json["flag"],
        code: json["code"],
        dialCode: json["dial_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "flag": flag,
        "code": code,
        "dial_code": dialCode,
      };
}
