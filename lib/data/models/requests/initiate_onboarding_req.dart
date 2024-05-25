import 'dart:convert';

InitiateOnboardingReq countryModelFromJson(String str) =>
    InitiateOnboardingReq.fromJson(json.decode(str));

String countryModelToJson(InitiateOnboardingReq data) =>
    json.encode(data.toJson());

class InitiateOnboardingReq {
  String? partnerCode;
  String? firstName;
  String? lastName;
  String? middleName;
  String? email;
  String? customerType;
  String? countryCode;
  String? phoneNumber;

  InitiateOnboardingReq({
    this.partnerCode,
    this.firstName,
    this.lastName,
    this.middleName,
    this.email,
    this.customerType,
    this.countryCode,
    this.phoneNumber,
  });

  InitiateOnboardingReq copyWith({
    String? partnerCode,
    String? firstName,
    String? lastName,
    String? middleName,
    String? email,
    String? customerType,
    String? countryCode,
    String? phoneNumber,
  }) =>
      InitiateOnboardingReq(
        partnerCode: partnerCode ?? this.partnerCode,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        middleName: middleName ?? this.middleName,
        email: email ?? this.email,
        customerType: customerType ?? this.customerType,
        countryCode: countryCode ?? this.countryCode,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  factory InitiateOnboardingReq.fromJson(Map<String, dynamic> json) =>
      InitiateOnboardingReq(
        partnerCode: json["partnerCode"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        middleName: json["middleName"],
        email: json["email"],
        customerType: json["customerType"],
        countryCode: json["countryCode"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "email": email,
        "customerType": customerType,
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
      };
}
