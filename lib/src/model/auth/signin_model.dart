import 'dart:convert';

LoginData dataModelFromMap(String str) => LoginData.fromMap(json.decode(str));

String dataModelToMap(LoginData data) => json.encode(data.toMap());

class LoginData {
    User? user;
    String? token;
    DateTime? expires;

    LoginData({
        this.user,
        this.token,
        this.expires,
    });

    factory LoginData.fromMap(Map<String, dynamic> json) => LoginData(
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        token: json["token"],
        expires: json["expires"] == null ? null : DateTime.parse(json["expires"]),
    );

    Map<String, dynamic> toMap() => {
        "user": user?.toMap(),
        "token": token,
        "expires": expires?.toIso8601String(),
    };
}

class User {
    int? id;
    String? userName;
    String? mailId;
    String? firstName;
    String? lastName;
    dynamic role;
    int? roleId;
    int? storeId;
    int? doctorId;
    String? mailDomain;
    bool? loginStatus;
    bool? isActive;
    bool? isDoctorType;
    bool? isPoVerify;
    bool? isGrnVerify;
    bool? isCollection;
    bool? isBedStatus;
    bool? isCurrentStk;
    bool? isPatientInfo;
    bool? isDateInterval;
    int? isDateIntervalDays;
    bool? addChargeIsDelete;
    bool? isIndentVerify;
    bool? isPoInchargeVerify;
    bool? isRefDocEditOpt;
    bool? isInchIndVfy;
    bool? isPharBalClearnace;
    int? webRoleId;
    bool? pharExtOpt;
    bool? pharOpOpt;
    bool? pharIpOpt;

    User({
        this.id,
        this.userName,
        this.mailId,
        this.firstName,
        this.lastName,
        this.role,
        this.roleId,
        this.storeId,
        this.doctorId,
        this.mailDomain,
        this.loginStatus,
        this.isActive,
        this.isDoctorType,
        this.isPoVerify,
        this.isGrnVerify,
        this.isCollection,
        this.isBedStatus,
        this.isCurrentStk,
        this.isPatientInfo,
        this.isDateInterval,
        this.isDateIntervalDays,
        this.addChargeIsDelete,
        this.isIndentVerify,
        this.isPoInchargeVerify,
        this.isRefDocEditOpt,
        this.isInchIndVfy,
        this.isPharBalClearnace,
        this.webRoleId,
        this.pharExtOpt,
        this.pharOpOpt,
        this.pharIpOpt,
    });

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["userName"],
        mailId: json["mailId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        role: json["role"],
        roleId: json["roleId"],
        storeId: json["storeId"],
        doctorId: json["doctorID"],
        mailDomain: json["mailDomain"],
        loginStatus: json["loginStatus"],
        isActive: json["isActive"],
        isDoctorType: json["isDoctorType"],
        isPoVerify: json["isPOVerify"],
        isGrnVerify: json["isGRNVerify"],
        isCollection: json["isCollection"],
        isBedStatus: json["isBedStatus"],
        isCurrentStk: json["isCurrentStk"],
        isPatientInfo: json["isPatientInfo"],
        isDateInterval: json["isDateInterval"],
        isDateIntervalDays: json["isDateIntervalDays"],
        addChargeIsDelete: json["addChargeIsDelete"],
        isIndentVerify: json["isIndentVerify"],
        isPoInchargeVerify: json["isPOInchargeVerify"],
        isRefDocEditOpt: json["isRefDocEditOpt"],
        isInchIndVfy: json["isInchIndVfy"],
        isPharBalClearnace: json["isPharBalClearnace"],
        webRoleId: json["webRoleId"],
        pharExtOpt: json["pharExtOpt"],
        pharOpOpt: json["pharOPOpt"],
        pharIpOpt: json["pharIPOpt"],
    );
Map<String, dynamic> toMap() => {
        "id": id,
        "userName": userName,
        "mailId": mailId,
        "firstName": firstName,
        "lastName": lastName,
        "role": role,
        "roleId": roleId,
        "storeId": storeId,
        "doctorID": doctorId,
        "mailDomain": mailDomain,
        "loginStatus": loginStatus,
        "isActive": isActive,
        "isDoctorType": isDoctorType,
        "isPOVerify": isPoVerify,
        "isGRNVerify": isGrnVerify,
        "isCollection": isCollection,
        "isBedStatus": isBedStatus,
        "isCurrentStk": isCurrentStk,
        "isPatientInfo": isPatientInfo,
        "isDateInterval": isDateInterval,
        "isDateIntervalDays": isDateIntervalDays,
        "addChargeIsDelete": addChargeIsDelete,
        "isIndentVerify": isIndentVerify,
        "isPOInchargeVerify": isPoInchargeVerify,
        "isRefDocEditOpt": isRefDocEditOpt,
        "isInchIndVfy": isInchIndVfy,
        "isPharBalClearnace": isPharBalClearnace,
        "webRoleId": webRoleId,
        "pharExtOpt": pharExtOpt,
        "pharOPOpt": pharOpOpt,
        "pharIPOpt": pharIpOpt,
    };
}