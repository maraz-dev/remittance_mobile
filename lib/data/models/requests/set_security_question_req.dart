import 'dart:convert';

import 'package:remittance_mobile/data/models/requests/security_questions_req.dart';

SetSecurityQuestionReq setQuestionReqFromJson(String str) =>
    SetSecurityQuestionReq.fromJson(json.decode(str));

String setQuestionReqToJson(SetSecurityQuestionReq data) =>
    json.encode(data.toJson());

class SetSecurityQuestionReq {
  List<SecurityQuestionReq>? securityQuestions;

  SetSecurityQuestionReq({
    this.securityQuestions,
  });

  SetSecurityQuestionReq copyWith({
    List<SecurityQuestionReq>? securityQuestions,
  }) =>
      SetSecurityQuestionReq(
        securityQuestions: securityQuestions ?? this.securityQuestions,
      );

  factory SetSecurityQuestionReq.fromJson(Map<String, dynamic> json) =>
      SetSecurityQuestionReq(
        securityQuestions: json["securityQuestions"] == null
            ? []
            : List<SecurityQuestionReq>.from(json["securityQuestions"]!
                .map((x) => SecurityQuestionReq.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "securityQuestions": securityQuestions == null
            ? []
            : List<dynamic>.from(securityQuestions!.map((x) => x.toJson())),
      };
}
