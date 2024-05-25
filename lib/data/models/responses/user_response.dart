class UserResponse {
  String? userId;
  String? firstName;
  String? lastName;
  dynamic middleName;
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
  DateTime? tokenExpiresAt;
  Permissions? permissions;
  bool? changePassword;
  bool? isLiveMode;

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
    this.tokenExpiresAt,
    this.permissions,
    this.changePassword,
    this.isLiveMode,
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
        tokenExpiresAt: json["tokenExpiresAt"] == null
            ? null
            : DateTime.parse(json["tokenExpiresAt"]),
        permissions: json["permissions"] == null
            ? null
            : Permissions.fromJson(json["permissions"]),
        changePassword: json["changePassword"],
        isLiveMode: json["isLiveMode"],
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
        "tokenExpiresAt": tokenExpiresAt?.toIso8601String(),
        "permissions": permissions?.toJson(),
        "changePassword": changePassword,
        "isLiveMode": isLiveMode,
      };
}

class Permissions {
  List<String>? backoffice;
  List<String>? auth;

  Permissions({
    this.backoffice,
    this.auth,
  });

  factory Permissions.fromJson(Map<String, dynamic> json) => Permissions(
        backoffice: json["Backoffice"] == null
            ? []
            : List<String>.from(json["Backoffice"]!.map((x) => x)),
        auth: json["Auth"] == null
            ? []
            : List<String>.from(json["Auth"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Backoffice": backoffice == null
            ? []
            : List<dynamic>.from(backoffice!.map((x) => x)),
        "Auth": auth == null ? [] : List<dynamic>.from(auth!.map((x) => x)),
      };
}
