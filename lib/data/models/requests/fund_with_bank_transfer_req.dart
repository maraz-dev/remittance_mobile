import 'dart:convert';

FundWithBankTransferReq fundWithBankTransferReqFromJson(String str) =>
    FundWithBankTransferReq.fromJson(json.decode(str));

String fundWithBankTransferReqToJson(FundWithBankTransferReq data) => json.encode(data.toJson());

class FundWithBankTransferReq {
  final num? amount;
  final String? accountNumber;

  FundWithBankTransferReq({
    this.amount,
    this.accountNumber,
  });

  FundWithBankTransferReq copyWith({
    num? amount,
    String? accountNumber,
  }) =>
      FundWithBankTransferReq(
        amount: amount ?? this.amount,
        accountNumber: accountNumber ?? this.accountNumber,
      );

  factory FundWithBankTransferReq.fromJson(Map<String, dynamic> json) => FundWithBankTransferReq(
        amount: json["amount"],
        accountNumber: json["accountNumber"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "accountNumber": accountNumber,
      };
}
