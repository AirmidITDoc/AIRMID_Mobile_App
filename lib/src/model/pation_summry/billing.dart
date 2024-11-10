import 'dart:convert';

List<BilingData> patienSummryFromMap(String str) =>
    List<BilingData>.from(json.decode(str).map((x) => BilingData.fromMap(x)));

String patienSummryToMap(List<BilingData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class BilingData {
  int? opdIpdId;
  DateTime? billDate;
  String? pBillNo;
  dynamic billNo;
  double? billAmount;
  double? discAmount;
  double? netAmount;
  double? balanceAmt;
  double? paidAmount;
  double? cashPay;
  double? chequePay;
  double? cardPay;
  double? onlinePay;

  BilingData({
    this.opdIpdId,
    this.billDate,
    this.pBillNo,
    this.billAmount,
    this.discAmount,
    this.netAmount,
    this.balanceAmt,
    this.paidAmount,
    this.cashPay,
    this.chequePay,
    this.cardPay,
    this.onlinePay,
    this.billNo,
  });

  factory BilingData.fromMap(Map<String, dynamic> json) => BilingData(
        opdIpdId: json["OPD_IPD_ID"],
        billDate: DateTime.parse(json["BillDate"]),
        pBillNo: json["PBillNo"],
        billAmount: json["BillAmount"],
        discAmount: json["DiscAmount"],
        netAmount: json["NetAmount"],
        balanceAmt: json["BalanceAmt"],
        paidAmount: json["PaidAmount"],
        cashPay: json["CashPay"],
        chequePay: json["ChequePay"],
        cardPay: json["CardPay"],
        onlinePay: json["OnlinePay"],
        billNo: json["BillNo"],
      );
  static List<BilingData> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<BilingData>.from(
      json.map(
        (v) => BilingData.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "OPD_IPD_ID": opdIpdId,
        "BillDate": billDate?.toIso8601String(),
        "PBillNo": pBillNo,
        "BillAmount": billAmount,
        "DiscAmount": discAmount,
        "NetAmount": netAmount,
        "BalanceAmt": balanceAmt,
        "PaidAmount": paidAmount,
        "CashPay": cashPay,
        "ChequePay": chequePay,
        "CardPay": cardPay,
        "OnlinePay": onlinePay,
        "BillNo": billNo,
      };
}
