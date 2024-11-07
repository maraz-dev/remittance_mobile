class KycSubmission {
  String? userId;
  String? bvnOrSsn;
  DateTime? dateOfBirth;
  String? meansOfIdType;
  String? meansOfIdDocFrontPath;
  String? meansOfIdDocBackPath;
  String? selfiePath;
  String? proofOfAddressType;
  String? proofOfAddressDocPath;

  KycSubmission({
    this.userId,
    this.bvnOrSsn,
    this.dateOfBirth,
    this.meansOfIdType,
    this.meansOfIdDocFrontPath,
    this.meansOfIdDocBackPath,
    this.selfiePath,
    this.proofOfAddressType,
    this.proofOfAddressDocPath,
  });

  factory KycSubmission.fromJson(Map<String, dynamic> json) => KycSubmission(
        userId: json["userId"],
        bvnOrSsn: json["bvnOrSsn"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        meansOfIdType: json["meansOfIdType"],
        meansOfIdDocFrontPath: json["meansOfIdDocFrontPath"],
        meansOfIdDocBackPath: json["meansOfIdDocBackPath"],
        selfiePath: json["selfiePath"],
        proofOfAddressType: json["proofOfAddressType"],
        proofOfAddressDocPath: json["proofOfAddressDocPath"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "bvnOrSsn": bvnOrSsn,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "meansOfIdType": meansOfIdType,
        "meansOfIdDocFrontPath": meansOfIdDocFrontPath,
        "meansOfIdDocBackPath": meansOfIdDocBackPath,
        "selfiePath": selfiePath,
        "proofOfAddressType": proofOfAddressType,
        "proofOfAddressDocPath": proofOfAddressDocPath,
      };
}
