import 'dart:convert';

FundWithBankTransferDto fundWithBankTransferDtoFromJson(String str) =>
    FundWithBankTransferDto.fromJson(json.decode(str));

String fundWithBankTransferDtoToJson(FundWithBankTransferDto data) => json.encode(data.toJson());

class FundWithBankTransferDto {
  final String? bank;
  final String? account;
  final num? amount;
  final String? requestId;

  FundWithBankTransferDto({
    this.bank,
    this.account,
    this.amount,
    this.requestId,
  });

  factory FundWithBankTransferDto.fromJson(Map<String, dynamic> json) => FundWithBankTransferDto(
        bank: json["bank"],
        account: json["account"],
        amount: json["amount"],
        requestId: json["requestId"],
      );

  Map<String, dynamic> toJson() => {
        "bank": bank,
        "account": account,
        "amount": amount,
        "requestId": requestId,
      };
}
