class KycStatus {
  dynamic userId;
  bool? isKycCompleted;
  String? validationStatus;
  bool? submitBvnOrSsn;
  bool? submitMeansOfId;
  bool? submitSelfie;
  bool? submitProofOfAddress;
  dynamic comment;

  KycStatus({
    this.userId,
    this.isKycCompleted,
    this.validationStatus,
    this.submitBvnOrSsn,
    this.submitMeansOfId,
    this.submitSelfie,
    this.submitProofOfAddress,
    this.comment,
  });

  factory KycStatus.fromJson(Map<String, dynamic> json) => KycStatus(
        userId: json["userId"],
        isKycCompleted: json["isKycCompleted"],
        validationStatus: json["validationStatus"],
        submitBvnOrSsn: json["submitBvnOrSsn"],
        submitMeansOfId: json["submitMeansOfId"],
        submitSelfie: json["submitSelfie"],
        submitProofOfAddress: json["submitProofOfAddress"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "isKycCompleted": isKycCompleted,
        "validationStatus": validationStatus,
        "submitBvnOrSsn": submitBvnOrSsn,
        "submitMeansOfId": submitMeansOfId,
        "submitSelfie": submitSelfie,
        "submitProofOfAddress": submitProofOfAddress,
        "comment": comment,
      };
}
