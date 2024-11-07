class SecurityQuestionItem {
  String? id;
  String? question;
  String? createdBy;
  DateTime? dateCreated;
  DateTime? dateModified;
  dynamic modifiedBy;

  SecurityQuestionItem({
    this.id,
    this.question,
    this.createdBy,
    this.dateCreated,
    this.dateModified,
    this.modifiedBy,
  });

  factory SecurityQuestionItem.fromJson(Map<String, dynamic> json) =>
      SecurityQuestionItem(
        id: json["id"],
        question: json["question"],
        createdBy: json["createdBy"],
        dateCreated: json["dateCreated"] == null
            ? null
            : DateTime.parse(json["dateCreated"]),
        dateModified: json["dateModified"] == null
            ? null
            : DateTime.parse(json["dateModified"]),
        modifiedBy: json["modifiedBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "createdBy": createdBy,
        "dateCreated": dateCreated?.toIso8601String(),
        "dateModified": dateModified?.toIso8601String(),
        "modifiedBy": modifiedBy,
      };
}
