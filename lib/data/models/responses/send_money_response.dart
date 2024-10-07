class SendMoneyResponse {
  final String? id;
  final String? name;
  final String? description;
  final String? createdBy;
  final DateTime? dateCreated;
  final DateTime? dateModified;
  final String? modifiedBy;

  SendMoneyResponse({
    this.id,
    this.name,
    this.description,
    this.createdBy,
    this.dateCreated,
    this.dateModified,
    this.modifiedBy,
  });

  factory SendMoneyResponse.fromJson(Map<String, dynamic> json) =>
      SendMoneyResponse(
        id: json["id"],
        name: json["name"],
        description: json["description"],
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
        "name": name,
        "description": description,
        "createdBy": createdBy,
        "dateCreated": dateCreated?.toIso8601String(),
        "dateModified": dateModified?.toIso8601String(),
        "modifiedBy": modifiedBy,
      };
}
