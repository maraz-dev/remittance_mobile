import 'dart:convert';

SendToMobileMoneyReq sendToMobileMoneyReqFromJson(String str) =>
    SendToMobileMoneyReq.fromJson(json.decode(str));

String sendToMobileMoneyReqToJson(SendToMobileMoneyReq data) =>
    json.encode(data.toJson());

class SendToMobileMoneyReq {
  final String? destinationCountryCode;
  final String? sourceCurrency;
  final String? destinationCurrency;
  final String? bankCode;
  final String? bankBranch;
  final String? sourceAccountNumber;
  final String? destinationAccountNumber;
  final String? destinationAccountName;
  final double? amount;
  final String? description;
  final String? deviceToken;
  final String? longitude;
  final String? latitude;
  final String? ipAddress;
  final String? serviceCode;
  final String? serviceTypeCode;

  SendToMobileMoneyReq({
    this.destinationCountryCode,
    this.sourceCurrency,
    this.destinationCurrency,
    this.bankCode,
    this.bankBranch,
    this.sourceAccountNumber,
    this.destinationAccountNumber,
    this.destinationAccountName,
    this.amount,
    this.description,
    this.deviceToken,
    this.longitude,
    this.latitude,
    this.ipAddress,
    this.serviceCode,
    this.serviceTypeCode,
  });

  SendToMobileMoneyReq copyWith({
    String? destinationCountryCode,
    String? sourceCurrency,
    String? destinationCurrency,
    String? bankCode,
    String? bankBranch,
    String? sourceAccountNumber,
    String? destinationAccountNumber,
    String? destinationAccountName,
    double? amount,
    String? description,
    String? deviceToken,
    String? longitude,
    String? latitude,
    String? ipAddress,
    String? serviceCode,
    String? serviceTypeCode,
  }) =>
      SendToMobileMoneyReq(
        destinationCountryCode:
            destinationCountryCode ?? this.destinationCountryCode,
        sourceCurrency: sourceCurrency ?? this.sourceCurrency,
        destinationCurrency: destinationCurrency ?? this.destinationCurrency,
        bankCode: bankCode ?? this.bankCode,
        bankBranch: bankBranch ?? this.bankBranch,
        sourceAccountNumber: sourceAccountNumber ?? this.sourceAccountNumber,
        destinationAccountNumber:
            destinationAccountNumber ?? this.destinationAccountNumber,
        destinationAccountName:
            destinationAccountName ?? this.destinationAccountName,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        deviceToken: deviceToken ?? this.deviceToken,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        ipAddress: ipAddress ?? this.ipAddress,
        serviceCode: serviceCode ?? this.serviceCode,
        serviceTypeCode: serviceTypeCode ?? this.serviceTypeCode,
      );

  factory SendToMobileMoneyReq.fromJson(Map<String, dynamic> json) =>
      SendToMobileMoneyReq(
        destinationCountryCode: json["destinationCountryCode"],
        sourceCurrency: json["sourceCurrency"],
        destinationCurrency: json["destinationCurrency"],
        bankCode: json["bankCode"],
        bankBranch: json["bankBranch"],
        sourceAccountNumber: json["sourceAccountNumber"],
        destinationAccountNumber: json["destinationAccountNumber"],
        destinationAccountName: json["destinationAccountName"],
        amount: json["amount"]?.toDouble(),
        description: json["description"],
        deviceToken: json["deviceToken"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        ipAddress: json["ipAddress"],
        serviceCode: json["serviceCode"],
        serviceTypeCode: json["serviceTypeCode"],
      );

  Map<String, dynamic> toJson() => {
        "destinationCountryCode": destinationCountryCode,
        "sourceCurrency": sourceCurrency,
        "destinationCurrency": destinationCurrency,
        "bankCode": bankCode,
        "bankBranch": bankBranch,
        "sourceAccountNumber": sourceAccountNumber,
        "destinationAccountNumber": destinationAccountNumber,
        "destinationAccountName": destinationAccountName,
        "amount": amount,
        "description": description,
        "deviceToken": deviceToken,
        "longitude": longitude,
        "latitude": latitude,
        "ipAddress": ipAddress,
        "serviceCode": serviceCode,
        "serviceTypeCode": serviceTypeCode,
      };
}
