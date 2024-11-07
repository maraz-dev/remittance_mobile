import 'dart:convert';

SecurityQuestionReq securityQuestionReqFromJson(String str) =>
    SecurityQuestionReq.fromJson(json.decode(str));

String securityQuestionReqToJson(SecurityQuestionReq data) => json.encode(data.toJson());

class SecurityQuestionReq {
  final String? code;
  final String? emailAddress;
  final String? deviceId;
  final String? deviceType;
  final String? deviceToken;
  final String? clientChannel;
  final String? userAgent;
  final String? ipAddress;
  final bool? isAndroidDevice;
  final String? location;
  final String? latitude;
  final String? longitude;
  final String? questionId;
  final String? answer;
  final String? pin;
  final bool? isPin;
  final String? partnerCode;

  SecurityQuestionReq({
    this.code,
    this.emailAddress,
    this.deviceId,
    this.deviceType,
    this.deviceToken,
    this.clientChannel,
    this.userAgent,
    this.ipAddress,
    this.isAndroidDevice,
    this.location,
    this.latitude,
    this.longitude,
    this.questionId,
    this.answer,
    this.pin,
    this.isPin,
    this.partnerCode,
  });

  SecurityQuestionReq copyWith({
    String? code,
    String? emailAddress,
    String? deviceId,
    String? deviceType,
    String? deviceToken,
    String? clientChannel,
    String? userAgent,
    String? ipAddress,
    bool? isAndroidDevice,
    String? location,
    String? latitude,
    String? longitude,
    String? questionId,
    String? answer,
    String? pin,
    bool? isPin,
    String? partnerCode,
  }) =>
      SecurityQuestionReq(
        code: code ?? this.code,
        emailAddress: emailAddress ?? this.emailAddress,
        deviceId: deviceId ?? this.deviceId,
        deviceType: deviceType ?? this.deviceType,
        deviceToken: deviceToken ?? this.deviceToken,
        clientChannel: clientChannel ?? this.clientChannel,
        userAgent: userAgent ?? this.userAgent,
        ipAddress: ipAddress ?? this.ipAddress,
        isAndroidDevice: isAndroidDevice ?? this.isAndroidDevice,
        location: location ?? this.location,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        questionId: questionId ?? this.questionId,
        answer: answer ?? this.answer,
        pin: pin ?? this.pin,
        isPin: isPin ?? this.isPin,
        partnerCode: partnerCode ?? this.partnerCode,
      );

  factory SecurityQuestionReq.fromJson(Map<String, dynamic> json) => SecurityQuestionReq(
        code: json["code"],
        emailAddress: json["emailAddress"],
        deviceId: json["deviceId"],
        deviceType: json["deviceType"],
        deviceToken: json["deviceToken"],
        clientChannel: json["clientChannel"],
        userAgent: json["userAgent"],
        ipAddress: json["ipAddress"],
        isAndroidDevice: json["isAndroidDevice"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        questionId: json["questionId"],
        answer: json["answer"],
        pin: json["pin"],
        isPin: json["isPin"],
        partnerCode: json["partnerCode"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "emailAddress": emailAddress,
        "deviceId": deviceId,
        "deviceType": deviceType,
        "deviceToken": deviceToken,
        "clientChannel": clientChannel,
        "userAgent": userAgent,
        "ipAddress": ipAddress,
        "isAndroidDevice": isAndroidDevice,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "questionId": questionId,
        "answer": answer,
        "pin": pin,
        "isPin": isPin,
        "partnerCode": partnerCode,
      };
}
