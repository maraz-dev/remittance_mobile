import 'dart:convert';

UssdBanksDto ussdBanksDtoFromJson(String str) => UssdBanksDto.fromJson(json.decode(str));

String ussdBanksDtoToJson(UssdBanksDto data) => json.encode(data.toJson());

class UssdBanksDto {
  final String? bank;
  final String? code;

  UssdBanksDto({
    this.bank,
    this.code,
  });

  factory UssdBanksDto.fromJson(Map<String, dynamic> json) => UssdBanksDto(
        bank: json["bank"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "bank": bank,
        "code": code,
      };
}
