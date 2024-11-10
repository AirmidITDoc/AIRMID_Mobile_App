import 'package:airmid/src/model/pation_summry/billing.dart';
import 'package:airmid/src/utils/extantion.dart';
import 'package:airmid/src/view/patient_sumaary/widget/biling_details.dart';
import 'package:airmid/src/widget/animated_button.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BilingCardData extends StatefulWidget {
  final BilingData bilingDataSummryData;
  const BilingCardData({super.key, required this.bilingDataSummryData});

  @override
  State<BilingCardData> createState() => _BilingCardDataState();
}

class _BilingCardDataState extends State<BilingCardData> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BilingDetails(billNo: widget.bilingDataSummryData.billNo),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 5,
            color: Colors.white,
            shadowColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      _nameUi(
                        title: "Bill No:  ",
                        subTitle: widget.bilingDataSummryData.pBillNo ?? "",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      _nameUi(
                        title: "",
                        subTitle: widget.bilingDataSummryData.billDate
                                ?.toFormattedString() ??
                            "",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  FxBox.h16,
                  _table(
                    title: "Bill Amount",
                    data:
                        "₹ ${widget.bilingDataSummryData.billAmount.toString()}",
                  ),
                  FxBox.h4,
                  _table(
                    title: "Discount %",
                    data:
                        "${widget.bilingDataSummryData.discAmount.toString()}",
                  ),
                  FxBox.h4,
                  _table(
                    title: "Net. Amount",
                    data:
                        "₹ ${widget.bilingDataSummryData.netAmount.toString()}",
                  ),
                  FxBox.h4,
                  if (widget.bilingDataSummryData.chequePay != 0.0000) ...[
                    FxBox.h4,
                    _table(
                      title: "ChequePay",
                      data:
                          "₹ ${widget.bilingDataSummryData.chequePay.toString()}",
                    ),
                  ],
                  if (widget.bilingDataSummryData.cardPay != 0.0000) ...[
                    FxBox.h4,
                    _table(
                      title: "CardPay",
                      data:
                          "₹ ${widget.bilingDataSummryData.cardPay.toString()}",
                    ),
                  ],
                  if (widget.bilingDataSummryData.cashPay != 0.0000) ...[
                    FxBox.h4,
                    _table(
                      title: "CashPay",
                      data:
                          "₹ ${widget.bilingDataSummryData.cashPay.toString()}",
                    ),
                  ],
                  if (widget.bilingDataSummryData.onlinePay != 0.0000) ...[
                    FxBox.h4,
                    _table(
                      title: "OnlinePay",
                      data:
                          "₹ ${widget.bilingDataSummryData.onlinePay.toString()}",
                    ),
                  ],
                  if (widget.bilingDataSummryData.paidAmount != 0.0000) ...[
                    FxBox.h4,
                    _table(
                      title: "PaidAmount",
                      data:
                          "₹ ${widget.bilingDataSummryData.paidAmount.toString()}",
                    ),
                  ],
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -12,
            right: -10,
            child: AnimatedButton(isCard: true),
          )
        ],
      ),
    );
  }

  Widget _nameUi(
      {required String title, required String subTitle, TextStyle? style}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
        ),
        Text(
          subTitle,
          style: style ??
              TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17.sp,
              ),
        ),
      ],
    );
  }

  Widget _table({
    required String title,
    required String data,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffDDDDDD)),
        borderRadius: BorderRadius.circular(4).r,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 36.h,
              decoration: BoxDecoration(
                color: Color(0xffDDDDDD),
              ),
              child: Center(
                child: Text(title),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 36.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      width: 100.w,
                      height: 50.h,
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.only(left: 20).r,
                        decoration: BoxDecoration(
                          color: Color(0xffF6F6F6),
                        ),
                        child: Center(
                          child: Text(
                            data,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
