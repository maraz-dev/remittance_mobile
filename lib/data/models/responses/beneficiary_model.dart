import 'dart:convert';

BeneficiaryModel beneficiaryModelFromJson(String str) =>
    BeneficiaryModel.fromJson(json.decode(str));

String beneficiaryModelToJson(BeneficiaryModel data) =>
    json.encode(data.toJson());

class BeneficiaryModel {
  final String? id;
  final bool? isActive;
  final bool? isDeleted;
  final String? partnerCode;
  final String? userId;
  final String? serviceTypeCode;
  final String? serviceType;
  final String? channel;
  final String? currency;
  final String? sourceCountry;
  final String? sourceCurrency;
  final String? destinationCountry;
  final String? destinationCurrency;
  final String? sourceCountryCode;
  final String? destinationCountryCode;
  final String? iban;
  final String? transitNumber;
  final String? routingNumber;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? bankCode;
  final String? bankName;
  final String? sourceAccountNumber;
  final String? accountNumber;
  final String? accountName;
  final String? phoneNumber;
  final String? email;
  final String? smartCodeNumber;
  final String? meterNumber;

  BeneficiaryModel({
    this.id,
    this.isActive,
    this.isDeleted,
    this.partnerCode,
    this.userId,
    this.serviceTypeCode,
    this.serviceType,
    this.channel,
    this.currency,
    this.sourceCountry,
    this.sourceCurrency,
    this.destinationCountry,
    this.destinationCurrency,
    this.sourceCountryCode,
    this.destinationCountryCode,
    this.iban,
    this.transitNumber,
    this.routingNumber,
    this.firstName,
    this.lastName,
    this.fullName,
    this.bankCode,
    this.bankName,
    this.sourceAccountNumber,
    this.accountNumber,
    this.accountName,
    this.phoneNumber,
    this.email,
    this.smartCodeNumber,
    this.meterNumber,
  });

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) =>
      BeneficiaryModel(
        id: json["id"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        partnerCode: json["partnerCode"],
        userId: json["userId"],
        serviceTypeCode: json["serviceTypeCode"],
        serviceType: json["serviceType"],
        channel: json["channel"],
        currency: json["currency"],
        sourceCountry: json["sourceCountry"],
        sourceCurrency: json["sourceCurrency"],
        destinationCountry: json["destinationCountry"],
        destinationCurrency: json["destinationCurrency"],
        sourceCountryCode: json["sourceCountryCode"],
        destinationCountryCode: json["destinationCountryCode"],
        iban: json["iban"],
        transitNumber: json["transitNumber"],
        routingNumber: json["routingNumber"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        bankCode: json["bankCode"],
        bankName: json["bankName"],
        sourceAccountNumber: json["sourceAccountNumber"],
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        smartCodeNumber: json["smartCodeNumber"],
        meterNumber: json["meterNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "partnerCode": partnerCode,
        "userId": userId,
        "serviceTypeCode": serviceTypeCode,
        "serviceType": serviceType,
        "channel": channel,
        "currency": currency,
        "sourceCountry": sourceCountry,
        "sourceCurrency": sourceCurrency,
        "destinationCountry": destinationCountry,
        "destinationCurrency": destinationCurrency,
        "sourceCountryCode": sourceCountryCode,
        "destinationCountryCode": destinationCountryCode,
        "iban": iban,
        "transitNumber": transitNumber,
        "routingNumber": routingNumber,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "bankCode": bankCode,
        "bankName": bankName,
        "sourceAccountNumber": sourceAccountNumber,
        "accountNumber": accountNumber,
        "accountName": accountName,
        "phoneNumber": phoneNumber,
        "email": email,
        "smartCodeNumber": smartCodeNumber,
        "meterNumber": meterNumber,
      };
}
