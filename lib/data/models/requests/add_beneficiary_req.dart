import 'dart:convert';

AddBeneficiaryReq addBeneficiaryReqFromJson(String str) =>
    AddBeneficiaryReq.fromJson(json.decode(str));

String addBeneficiaryReqToJson(AddBeneficiaryReq data) =>
    json.encode(data.toJson());

class AddBeneficiaryReq {
  final String? serviceTypeCode;
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

  AddBeneficiaryReq({
    this.serviceTypeCode,
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

  AddBeneficiaryReq copyWith({
    String? serviceTypeCode,
    String? channel,
    String? currency,
    String? sourceCountry,
    String? sourceCurrency,
    String? destinationCountry,
    String? destinationCurrency,
    String? sourceCountryCode,
    String? destinationCountryCode,
    String? iban,
    String? transitNumber,
    String? routingNumber,
    String? firstName,
    String? lastName,
    String? fullName,
    String? bankCode,
    String? bankName,
    String? sourceAccountNumber,
    String? accountNumber,
    String? accountName,
    String? phoneNumber,
    String? email,
    String? smartCodeNumber,
    String? meterNumber,
  }) =>
      AddBeneficiaryReq(
        serviceTypeCode: serviceTypeCode ?? this.serviceTypeCode,
        channel: channel ?? this.channel,
        currency: currency ?? this.currency,
        sourceCountry: sourceCountry ?? this.sourceCountry,
        sourceCurrency: sourceCurrency ?? this.sourceCurrency,
        destinationCountry: destinationCountry ?? this.destinationCountry,
        destinationCurrency: destinationCurrency ?? this.destinationCurrency,
        sourceCountryCode: sourceCountryCode ?? this.sourceCountryCode,
        destinationCountryCode:
            destinationCountryCode ?? this.destinationCountryCode,
        iban: iban ?? this.iban,
        transitNumber: transitNumber ?? this.transitNumber,
        routingNumber: routingNumber ?? this.routingNumber,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        fullName: fullName ?? this.fullName,
        bankCode: bankCode ?? this.bankCode,
        bankName: bankName ?? this.bankName,
        sourceAccountNumber: sourceAccountNumber ?? this.sourceAccountNumber,
        accountNumber: accountNumber ?? this.accountNumber,
        accountName: accountName ?? this.accountName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        smartCodeNumber: smartCodeNumber ?? this.smartCodeNumber,
        meterNumber: meterNumber ?? this.meterNumber,
      );

  factory AddBeneficiaryReq.fromJson(Map<String, dynamic> json) =>
      AddBeneficiaryReq(
        serviceTypeCode: json["serviceTypeCode"],
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
        "serviceTypeCode": serviceTypeCode,
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
