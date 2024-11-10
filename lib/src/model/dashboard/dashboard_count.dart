// To parse this JSON data, do
//
//     final dashboardCount = dashboardCountFromMap(jsonString);

import 'dart:convert';

List<DashboardCount> dashboardCountFromMap(String str) =>
    List<DashboardCount>.from(
        json.decode(str).map((x) => DashboardCount.fromMap(x)));

String dashboardCountToMap(List<DashboardCount> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DashboardCount {
  int? appointmentCount;
  int? totalAdmittedPatientCount;
  int? selfPatient;
  int? compnayPatient;
  int? todayAdmittedPatient;
  int? todayDischargePatient;
  int? todaySelfPatient;
  int? todayOtherPatient;

  DashboardCount({
    this.appointmentCount,
    this.totalAdmittedPatientCount,
    this.selfPatient,
    this.compnayPatient,
    this.todayAdmittedPatient,
    this.todayDischargePatient,
    this.todaySelfPatient,
    this.todayOtherPatient,
  });

  factory DashboardCount.fromMap(Map<String, dynamic> json) => DashboardCount(
        appointmentCount: json["AppointmentCount"],
        totalAdmittedPatientCount: json["TotalAdmittedPatientCount"],
        selfPatient: json["SelfPatient"],
        compnayPatient: json["CompnayPatient"],
        todayAdmittedPatient: json["TodayAdmittedPatient"],
        todayDischargePatient: json["TodayDischargePatient"],
        todaySelfPatient: json["TodaySelfPatient"],
        todayOtherPatient: json["TodayOtherPatient"],
      );

  Map<String, dynamic> toMap() => {
        "AppointmentCount": appointmentCount,
        "TotalAdmittedPatientCount": totalAdmittedPatientCount,
        "SelfPatient": selfPatient,
        "CompnayPatient": compnayPatient,
        "TodayAdmittedPatient": todayAdmittedPatient,
        "TodayDischargePatient": todayDischargePatient,
        "TodaySelfPatient": todaySelfPatient,
        "TodayOtherPatient": todayOtherPatient,
      };
}
