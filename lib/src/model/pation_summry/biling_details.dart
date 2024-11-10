import 'dart:convert';

List<BilingDetailsModel> bilingDetailsFromMap(String str) =>
    List<BilingDetailsModel>.from(
        json.decode(str).map((x) => BilingDetailsModel.fromMap(x)));

String bilingDetailsToMap(List<BilingDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class BilingDetailsModel {
  String? serviceName;
  double? price;
  double? qty;
  double? totalAmt;
  double? netAmount;
  dynamic doctorName;

  BilingDetailsModel({
    this.serviceName,
    this.price,
    this.qty,
    this.totalAmt,
    this.netAmount,
    this.doctorName,
  });

  factory BilingDetailsModel.fromMap(Map<String, dynamic> json) =>
      BilingDetailsModel(
        serviceName: json["ServiceName"],
        price: json["Price"],
        qty: json["Qty"],
        totalAmt: json["TotalAmt"],
        netAmount: json["NetAmount"],
        doctorName: json["DoctorName"],
      );
  static List<BilingDetailsModel> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<BilingDetailsModel>.from(
      json.map(
        (v) => BilingDetailsModel.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "ServiceName": serviceName,
        "Price": price,
        "Qty": qty,
        "TotalAmt": totalAmt,
        "NetAmount": netAmount,
        "DoctorName": doctorName,
      };
}
