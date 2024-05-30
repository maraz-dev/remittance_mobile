import 'dart:convert';

SecurityQuestionReq securityQuestionReqFromJson(String str) =>
    SecurityQuestionReq.fromJson(json.decode(str));

String securityQuestionReqToJson(SecurityQuestionReq data) =>
    json.encode(data.toJson());

class SecurityQuestionReq {
  String? questionId;
  String? answer;

  SecurityQuestionReq({
    this.questionId,
    this.answer,
  });

  SecurityQuestionReq copyWith({
    String? questionId,
    String? answer,
  }) =>
      SecurityQuestionReq(
        questionId: questionId ?? this.questionId,
        answer: answer ?? this.answer,
      );

  factory SecurityQuestionReq.fromJson(Map<String, dynamic> json) =>
      SecurityQuestionReq(
        questionId: json["questionId"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "answer": answer,
      };
}
