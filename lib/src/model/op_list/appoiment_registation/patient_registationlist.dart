import 'dart:convert';

List<GetPatientList> getPatientListFromMap(String str) =>
    List<GetPatientList>.from(
        json.decode(str).map((x) => GetPatientList.fromMap(x)));

String getPatientListToMap(List<GetPatientList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class GetPatientList {
  int regId;
  DateTime regDate;
  DateTime regTime;
  int prefixId;
  String prefixName;
  String firstName;
  String middleName;
  String lastName;
  String address;
  String city;
  String pinNo;
  DateTime dateofBirth;
  String age;
  String ageYear;
  String ageMonth;
  String ageDay;
  int genderId;
  String genderName;
  String phoneNo;
  String mobileNo;
  String aadharCardNo;
  String rDate;
  String regTimeDate;
  String regNo;
  String ageYear1;
  String ageMonth1;
  String ageDay1;
  int cityId;
  int stateId;
  int countryId;
  int maritalStatusId;
  bool isCharity;
  String regNoWithPrefix;
  int maritalStatusId1;
  int areaId;
  int cityId1;
  int religionId;
  int areaId1;

  GetPatientList({
    required this.regId,
    required this.regDate,
    required this.regTime,
    required this.prefixId,
    required this.prefixName,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.pinNo,
    required this.dateofBirth,
    required this.age,
    required this.ageYear,
    required this.ageMonth,
    required this.ageDay,
    required this.genderId,
    required this.genderName,
    required this.phoneNo,
    required this.mobileNo,
    required this.aadharCardNo,
    required this.rDate,
    required this.regTimeDate,
    required this.regNo,
    required this.ageYear1,
    required this.ageMonth1,
    required this.ageDay1,
    required this.cityId,
    required this.stateId,
    required this.countryId,
    required this.maritalStatusId,
    required this.isCharity,
    required this.regNoWithPrefix,
    required this.maritalStatusId1,
    required this.areaId,
    required this.cityId1,
    required this.religionId,
    required this.areaId1,
  });

  factory GetPatientList.fromMap(Map<String, dynamic> json) => GetPatientList(
        regId: json["RegId"],
        regDate: DateTime.parse(json["RegDate"]),
        regTime: DateTime.parse(json["RegTime"]),
        prefixId: json["PrefixID"],
        prefixName: json["PrefixName"],
        firstName: json["FirstName"],
        middleName: json["MiddleName"],
        lastName: json["LastName"],
        address: json["Address"],
        city: json["City"],
        pinNo: json["PinNo"],
        dateofBirth: DateTime.parse(json["DateofBirth"]),
        age: json["Age"],
        ageYear: json["AgeYear"],
        ageMonth: json["AgeMonth"],
        ageDay: json["AgeDay"],
        genderId: json["GenderId"],
        genderName: json["GenderName"],
        phoneNo: json["PhoneNo"],
        mobileNo: json["MobileNo"],
        aadharCardNo: json["AadharCardNo"],
        rDate: json["RDate"],
        regTimeDate: json["RegTimeDate"],
        regNo: json["RegNo"],
        ageYear1: json["AgeYear1"],
        ageMonth1: json["AgeMonth1"],
        ageDay1: json["AgeDay1"],
        cityId: json["CityId"],
        stateId: json["StateId"],
        countryId: json["CountryId"],
        maritalStatusId: json["MaritalStatusId"],
        isCharity: json["IsCharity"],
        regNoWithPrefix: json["RegNoWithPrefix"],
        maritalStatusId1: json["MaritalStatusId1"],
        areaId: json["AreaId"],
        cityId1: json["CityId1"],
        religionId: json["ReligionId"],
        areaId1: json["AreaId1"],
      );
  static List<GetPatientList> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<GetPatientList>.from(
      json.map(
        (v) => GetPatientList.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "RegId": regId,
        "RegDate": regDate.toIso8601String(),
        "RegTime": regTime.toIso8601String(),
        "PrefixID": prefixId,
        "PrefixName": prefixName,
        "FirstName": firstName,
        "MiddleName": middleName,
        "LastName": lastName,
        "Address": address,
        "City": city,
        "PinNo": pinNo,
        "DateofBirth": dateofBirth.toIso8601String(),
        "Age": age,
        "AgeYear": ageYear,
        "AgeMonth": ageMonth,
        "AgeDay": ageDay,
        "GenderId": genderId,
        "GenderName": genderName,
        "PhoneNo": phoneNo,
        "MobileNo": mobileNo,
        "AadharCardNo": aadharCardNo,
        "RDate": rDate,
        "RegTimeDate": regTimeDate,
        "RegNo": regNo,
        "AgeYear1": ageYear1,
        "AgeMonth1": ageMonth1,
        "AgeDay1": ageDay1,
        "CityId": cityId,
        "StateId": stateId,
        "CountryId": countryId,
        "MaritalStatusId": maritalStatusId,
        "IsCharity": isCharity,
        "RegNoWithPrefix": regNoWithPrefix,
        "MaritalStatusId1": maritalStatusId1,
        "AreaId": areaId,
        "CityId1": cityId1,
        "ReligionId": religionId,
        "AreaId1": areaId1,
      };
}
