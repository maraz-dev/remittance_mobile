class UserResponse {
  String? userId;
  String? firstName;
  String? lastName;
  String? middleName;
  String? partnerCode;
  dynamic businessCode;
  String? roleId;
  String? roleName;
  String? email;
  bool? isActive;
  bool? isKycComplete;
  bool? isPinSet;
  String? tokenType;
  String? token;
  String? refreshToken;
  String? onboardingStatus;
  String? kycProgress;
  String? onboardingRequestId;
  DateTime? tokenExpiresAt;
  bool? changePassword;
  bool? isLiveMode;
  dynamic deviceType;
  dynamic deviceToken;
  bool? isNewLogin;
  bool? isSecurityQuestionSet;

  UserResponse({
    this.userId,
    this.firstName,
    this.lastName,
    this.middleName,
    this.partnerCode,
    this.businessCode,
    this.roleId,
    this.roleName,
    this.email,
    this.isActive,
    this.isKycComplete,
    this.isPinSet,
    this.tokenType,
    this.token,
    this.refreshToken,
    this.onboardingStatus,
    this.kycProgress,
    this.onboardingRequestId,
    this.tokenExpiresAt,
    this.changePassword,
    this.isLiveMode,
    this.deviceType,
    this.deviceToken,
    this.isNewLogin,
    this.isSecurityQuestionSet,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        middleName: json["middleName"],
        partnerCode: json["partnerCode"],
        businessCode: json["businessCode"],
        roleId: json["roleId"],
        roleName: json["roleName"],
        email: json["email"],
        isActive: json["isActive"],
        isKycComplete: json["isKycComplete"],
        isPinSet: json["isPINSet"],
        tokenType: json["tokenType"],
        token: json["token"],
        refreshToken: json["refreshToken"],
        onboardingStatus: json["onboardingStatus"],
        kycProgress: json["kycProgress"],
        onboardingRequestId: json["onboardingRequestId"],
        tokenExpiresAt: json["tokenExpiresAt"] == null
            ? null
            : DateTime.parse(json["tokenExpiresAt"]),
        changePassword: json["changePassword"],
        isLiveMode: json["isLiveMode"],
        deviceType: json["deviceType"],
        deviceToken: json["deviceToken"],
        isNewLogin: json["isNewLogin"],
        isSecurityQuestionSet: json["isSecurityQuestionSet"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "partnerCode": partnerCode,
        "businessCode": businessCode,
        "roleId": roleId,
        "roleName": roleName,
        "email": email,
        "isActive": isActive,
        "isKycComplete": isKycComplete,
        "isPINSet": isPinSet,
        "tokenType": tokenType,
        "token": token,
        "refreshToken": refreshToken,
        "onboardingStatus": onboardingStatus,
        "kycProgress": kycProgress,
        "onboardingRequestId": onboardingRequestId,
        "tokenExpiresAt": tokenExpiresAt?.toIso8601String(),
        "changePassword": changePassword,
        "isLiveMode": isLiveMode,
        "deviceType": deviceType,
        "deviceToken": deviceToken,
        "isNewLogin": isNewLogin,
        "isSecurityQuestionSet": isSecurityQuestionSet,
      };
}
