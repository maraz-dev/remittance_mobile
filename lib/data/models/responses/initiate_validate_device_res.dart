import 'dart:convert';

InitiateValidateDeviceDto initiateValidateDeviceDtoFromJson(String str) =>
    InitiateValidateDeviceDto.fromJson(json.decode(str));

String initiateValidateDeviceDtoToJson(InitiateValidateDeviceDto data) =>
    json.encode(data.toJson());

class InitiateValidateDeviceDto {
  final bool? isPinSet;
  final bool? isSecurityQuestionSet;

  InitiateValidateDeviceDto({
    this.isPinSet,
    this.isSecurityQuestionSet,
  });

  factory InitiateValidateDeviceDto.fromJson(Map<String, dynamic> json) =>
      InitiateValidateDeviceDto(
        isPinSet: json["isPinSet"],
        isSecurityQuestionSet: json["isSecurityQuestionSet"],
      );

  Map<String, dynamic> toJson() => {
        "isPinSet": isPinSet,
        "isSecurityQuestionSet": isSecurityQuestionSet,
      };
}
