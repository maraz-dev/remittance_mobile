import 'dart:convert';

SendToBankReq sendToBankReqFromJson(String str) => SendToBankReq.fromJson(json.decode(str));

String sendToBankReqToJson(SendToBankReq data) => json.encode(data.toJson());

class SendToBankReq {
  final String? sourceCountryCode;
  final String? sourceCurrency;
  final String? sourceAccountNumber;
  final num? amount;
  final String? description;
  final String? deviceToken;
  final String? longitude;
  final String? latitude;
  final String? ipAddress;
  final String? channel;
  final String? destinationCountryCode;
  final String? destinationCurrency;
  final String? bankCode;
  final String? bankBranch;
  final String? destinationAccountNumber;
  final String? destinationAccountName;
  final String? swiftCode;
  final String? sortCode;
  final String? iban;
  final String? transitNumber;
  final String? routingNumber;
  final String? bankName;
  final String? bankAddress;
  final String? recipientCity;
  final String? recipientPostalCode;
  final String? recipientAddress;
  final String? accountType;
  final String? serviceCode;
  final String? serviceTypeCode;

  SendToBankReq({
    this.sourceCountryCode,
    this.sourceCurrency,
    this.sourceAccountNumber,
    this.amount,
    this.description,
    this.deviceToken,
    this.longitude,
    this.latitude,
    this.ipAddress,
    this.channel,
    this.destinationCountryCode,
    this.destinationCurrency,
    this.bankCode,
    this.bankBranch,
    this.destinationAccountNumber,
    this.destinationAccountName,
    this.swiftCode,
    this.sortCode,
    this.iban,
    this.transitNumber,
    this.routingNumber,
    this.bankName,
    this.bankAddress,
    this.recipientCity,
    this.recipientPostalCode,
    this.recipientAddress,
    this.accountType,
    this.serviceCode,
    this.serviceTypeCode,
  });

  SendToBankReq copyWith({
    String? sourceCountryCode,
    String? sourceCurrency,
    String? sourceAccountNumber,
    int? amount,
    String? description,
    String? deviceToken,
    String? longitude,
    String? latitude,
    String? ipAddress,
    String? channel,
    String? destinationCountryCode,
    String? destinationCurrency,
    String? bankCode,
    String? bankBranch,
    String? destinationAccountNumber,
    String? destinationAccountName,
    String? swiftCode,
    String? sortCode,
    String? iban,
    String? transitNumber,
    String? routingNumber,
    String? bankName,
    String? bankAddress,
    String? recipientCity,
    String? recipientPostalCode,
    String? recipientAddress,
    String? accountType,
    String? serviceCode,
    String? serviceTypeCode,
  }) =>
      SendToBankReq(
        sourceCountryCode: sourceCountryCode ?? this.sourceCountryCode,
        sourceCurrency: sourceCurrency ?? this.sourceCurrency,
        sourceAccountNumber: sourceAccountNumber ?? this.sourceAccountNumber,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        deviceToken: deviceToken ?? this.deviceToken,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        ipAddress: ipAddress ?? this.ipAddress,
        channel: channel ?? this.channel,
        destinationCountryCode: destinationCountryCode ?? this.destinationCountryCode,
        destinationCurrency: destinationCurrency ?? this.destinationCurrency,
        bankCode: bankCode ?? this.bankCode,
        bankBranch: bankBranch ?? this.bankBranch,
        destinationAccountNumber: destinationAccountNumber ?? this.destinationAccountNumber,
        destinationAccountName: destinationAccountName ?? this.destinationAccountName,
        swiftCode: swiftCode ?? this.swiftCode,
        sortCode: sortCode ?? this.sortCode,
        iban: iban ?? this.iban,
        transitNumber: transitNumber ?? this.transitNumber,
        routingNumber: routingNumber ?? this.routingNumber,
        bankName: bankName ?? this.bankName,
        bankAddress: bankAddress ?? this.bankAddress,
        recipientCity: recipientCity ?? this.recipientCity,
        recipientPostalCode: recipientPostalCode ?? this.recipientPostalCode,
        recipientAddress: recipientAddress ?? this.recipientAddress,
        accountType: accountType ?? this.accountType,
        serviceCode: serviceCode ?? this.serviceCode,
        serviceTypeCode: serviceTypeCode ?? this.serviceTypeCode,
      );

  factory SendToBankReq.fromJson(Map<String, dynamic> json) => SendToBankReq(
        sourceCountryCode: json["sourceCountryCode"],
        sourceCurrency: json["sourceCurrency"],
        sourceAccountNumber: json["sourceAccountNumber"],
        amount: json["amount"],
        description: json["description"],
        deviceToken: json["deviceToken"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        ipAddress: json["ipAddress"],
        channel: json["channel"],
        destinationCountryCode: json["destinationCountryCode"],
        destinationCurrency: json["destinationCurrency"],
        bankCode: json["bankCode"],
        bankBranch: json["bankBranch"],
        destinationAccountNumber: json["destinationAccountNumber"],
        destinationAccountName: json["destinationAccountName"],
        swiftCode: json["swiftCode"],
        sortCode: json["sortCode"],
        iban: json["iban"],
        transitNumber: json["transitNumber"],
        routingNumber: json["routingNumber"],
        bankName: json["bankName"],
        bankAddress: json["bankAddress"],
        recipientCity: json["recipientCity"],
        recipientPostalCode: json["recipientPostalCode"],
        recipientAddress: json["recipientAddress"],
        accountType: json["accountType"],
        serviceCode: json["serviceCode"],
        serviceTypeCode: json["serviceTypeCode"],
      );

  Map<String, dynamic> toJson() => {
        "sourceCountryCode": sourceCountryCode,
        "sourceCurrency": sourceCurrency,
        "sourceAccountNumber": sourceAccountNumber,
        "amount": amount,
        "description": description,
        "deviceToken": deviceToken,
        "longitude": longitude,
        "latitude": latitude,
        "ipAddress": ipAddress,
        "channel": channel,
        "destinationCountryCode": destinationCountryCode,
        "destinationCurrency": destinationCurrency,
        "bankCode": bankCode,
        "bankBranch": bankBranch,
        "destinationAccountNumber": destinationAccountNumber,
        "destinationAccountName": destinationAccountName,
        "swiftCode": swiftCode,
        "sortCode": sortCode,
        "iban": iban,
        "transitNumber": transitNumber,
        "routingNumber": routingNumber,
        "bankName": bankName,
        "bankAddress": bankAddress,
        "recipientCity": recipientCity,
        "recipientPostalCode": recipientPostalCode,
        "recipientAddress": recipientAddress,
        "accountType": accountType,
        "serviceCode": serviceCode,
        "serviceTypeCode": serviceTypeCode,
      };
}
