import 'dart:convert';

SendToMobileMoneyReq sendToMobileMoneyReqFromJson(String str) =>
    SendToMobileMoneyReq.fromJson(json.decode(str));

String sendToMobileMoneyReqToJson(SendToMobileMoneyReq data) => json.encode(data.toJson());

class SendToMobileMoneyReq {
  final String? sourceCountryCode;
  final String? destinationCountryCode;
  final String? sourceCurrency;
  final String? destinationCurrency;
  final String? bankCode;
  final String? sourceAccountNumber;
  final String? mobileMoneyNumber;
  final String? recipientName;
  final num? amount;
  final String? description;
  final String? deviceToken;
  final String? longitude;
  final String? latitude;
  final String? ipAddress;
  final String? channel;

  SendToMobileMoneyReq({
    this.sourceCountryCode,
    this.destinationCountryCode,
    this.sourceCurrency,
    this.destinationCurrency,
    this.bankCode,
    this.sourceAccountNumber,
    this.mobileMoneyNumber,
    this.recipientName,
    this.amount,
    this.description,
    this.deviceToken,
    this.longitude,
    this.latitude,
    this.ipAddress,
    this.channel,
  });

  SendToMobileMoneyReq copyWith({
    String? sourceCountryCode,
    String? destinationCountryCode,
    String? sourceCurrency,
    String? destinationCurrency,
    String? bankCode,
    String? sourceAccountNumber,
    String? mobileMoneyNumber,
    String? recipientName,
    int? amount,
    String? description,
    String? deviceToken,
    String? longitude,
    String? latitude,
    String? ipAddress,
    String? channel,
  }) =>
      SendToMobileMoneyReq(
        sourceCountryCode: sourceCountryCode ?? this.sourceCountryCode,
        destinationCountryCode: destinationCountryCode ?? this.destinationCountryCode,
        sourceCurrency: sourceCurrency ?? this.sourceCurrency,
        destinationCurrency: destinationCurrency ?? this.destinationCurrency,
        bankCode: bankCode ?? this.bankCode,
        sourceAccountNumber: sourceAccountNumber ?? this.sourceAccountNumber,
        mobileMoneyNumber: mobileMoneyNumber ?? this.mobileMoneyNumber,
        recipientName: recipientName ?? this.recipientName,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        deviceToken: deviceToken ?? this.deviceToken,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        ipAddress: ipAddress ?? this.ipAddress,
        channel: channel ?? this.channel,
      );

  factory SendToMobileMoneyReq.fromJson(Map<String, dynamic> json) => SendToMobileMoneyReq(
        sourceCountryCode: json["SourceCountryCode"],
        destinationCountryCode: json["DestinationCountryCode"],
        sourceCurrency: json["SourceCurrency"],
        destinationCurrency: json["DestinationCurrency"],
        bankCode: json["BankCode"],
        sourceAccountNumber: json["SourceAccountNumber"],
        mobileMoneyNumber: json["MobileMoneyNumber"],
        recipientName: json["RecipientName"],
        amount: json["Amount"],
        description: json["Description"],
        deviceToken: json["DeviceToken"],
        longitude: json["Longitude"],
        latitude: json["Latitude"],
        ipAddress: json["IpAddress"],
        channel: json["Channel"],
      );

  Map<String, dynamic> toJson() => {
        "SourceCountryCode": sourceCountryCode,
        "DestinationCountryCode": destinationCountryCode,
        "SourceCurrency": sourceCurrency,
        "DestinationCurrency": destinationCurrency,
        "BankCode": bankCode,
        "SourceAccountNumber": sourceAccountNumber,
        "MobileMoneyNumber": mobileMoneyNumber,
        "RecipientName": recipientName,
        "Amount": amount,
        "Description": description,
        "DeviceToken": deviceToken,
        "Longitude": longitude,
        "Latitude": latitude,
        "IpAddress": ipAddress,
        "Channel": channel,
      };
}
