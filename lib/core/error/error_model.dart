import 'dart:convert';

FailureRes failureResFromJson(String str) =>
    FailureRes.fromJson(json.decode(str));

class FailureRes {
  String message;
  String err;
  Error error;

  FailureRes({required this.message, required this.error, required this.err});

  factory FailureRes.fromJson(Map<String, dynamic> json) => FailureRes(
        message: json["message"] ?? "",
        err: json["error"] ?? "",
        error: Error.fromJson(json["errors"]),
      );
}

class Error {
  String? message;
  String? phoneNumber;
  String? email;
  String? firstName;
  String? lastName;
  String? username;
  String? referralCode;
  String? amount;
  String? code;
  String? pin;
  String? transactionPin;
  String? password;
  String? recipient;
  String? token;

  Error(
      {required this.message,
      this.phoneNumber,
      this.email,
      this.username,
      this.firstName,
      this.amount,
      this.code,
      this.pin,
      this.recipient,
      this.transactionPin,
      this.password,
      this.referralCode,
      this.token,
      this.lastName});

  factory Error.fromJson(Map<String, dynamic> json) => Error(
      message: json["message"] ?? "",
      phoneNumber: json["phone_number"] ?? "",
      email: json["email"] ?? "",
      firstName: json["first_name"] ?? "",
      amount: json["amount"] ?? "",
      pin: json["pin"] ?? "",
      code: json["code"] ?? "",
      lastName: json["last_name"] ?? "",
      referralCode: json["referral_code"] ?? "",
      transactionPin: json["transaction_pin"] ?? "",
      password: json["password"] ?? "",
      token: json["token"] ?? "",
      recipient: json["recipient"] ?? "",
      username: json["username"] ?? "");
  @override
  String toString() =>
      "message: $message ,register : {firstname:$firstName, lastname:$lastName,  referral_code:$referralCode}";
}
