import 'dart:convert';

InitiateOnboardingReq initiateOnboardingReqFromJson(String str) =>
    InitiateOnboardingReq.fromJson(json.decode(str));

String initiateOnboardingReqToJson(InitiateOnboardingReq data) =>
    json.encode(data.toJson());

class InitiateOnboardingReq {
  String? partnerCode;
  String? firstName;
  String? lastName;
  String? middleName;
  String? email;
  String? customerType;
  String? channel;
  String? countryCode;
  String? phoneNumber;

  InitiateOnboardingReq({
    this.partnerCode,
    this.firstName,
    this.lastName,
    this.middleName,
    this.email,
    this.customerType,
    this.channel,
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
    String? channel,
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
        channel: channel ?? this.channel,
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
        channel: json["channel"],
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
        "channel": channel,
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
      };
}
