import 'dart:convert';

InitiateUssdFundingReq initiateUssdFundingReqFromJson(String str) =>
    InitiateUssdFundingReq.fromJson(json.decode(str));

String initiateUssdFundingReqToJson(InitiateUssdFundingReq data) =>
    json.encode(data.toJson());

class InitiateUssdFundingReq {
  final String? bankCode;
  final int? amount;
  final int? charge;

  InitiateUssdFundingReq({
    this.bankCode,
    this.amount,
    this.charge,
  });

  InitiateUssdFundingReq copyWith({
    String? bankCode,
    int? amount,
    int? charge,
  }) =>
      InitiateUssdFundingReq(
        bankCode: bankCode ?? this.bankCode,
        amount: amount ?? this.amount,
        charge: charge ?? this.charge,
      );

  factory InitiateUssdFundingReq.fromJson(Map<String, dynamic> json) =>
      InitiateUssdFundingReq(
        bankCode: json["bankCode"],
        amount: json["amount"],
        charge: json["charge"],
      );

  Map<String, dynamic> toJson() => {
        "bankCode": bankCode,
        "amount": amount,
        "charge": charge,
      };
}
