class IdTypesItem {
  String? code;
  String? name;
  String? friendlyName;
  String? id;
  bool? isActive;
  bool? isDeleted;
  String? createdBy;
  DateTime? dateCreated;
  DateTime? dateModified;
  dynamic modifiedBy;

  IdTypesItem({
    this.code,
    this.name,
    this.friendlyName,
    this.id,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.dateCreated,
    this.dateModified,
    this.modifiedBy,
  });

  factory IdTypesItem.fromJson(Map<String, dynamic> json) => IdTypesItem(
        code: json["code"],
        name: json["name"],
        friendlyName: json["friendlyName"],
        id: json["id"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
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
        "code": code,
        "name": name,
        "friendlyName": friendlyName,
        "id": id,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "dateCreated": dateCreated?.toIso8601String(),
        "dateModified": dateModified?.toIso8601String(),
        "modifiedBy": modifiedBy,
      };
}
