import 'package:airmid/src/model/pation_summry/pathalogy.dart';
import 'package:airmid/src/utils/extantion.dart';
import 'package:airmid/src/widget/animated_button.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PathologyCardData extends StatefulWidget {
  final PathalogyModel patienSummryData;
  const PathologyCardData({super.key, required this.patienSummryData});

  @override
  State<PathologyCardData> createState() => _PathologyCardDataState();
}

class _PathologyCardDataState extends State<PathologyCardData> {
  @override
  Widget build(BuildContext context) {
    // return Card(
    //   elevation: 5,
    //   color: Colors.white,
    //   shadowColor: Colors.white,
    //   child: Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Row(
    //           children: [
    //             _nameUi(
    //               title: "Bill No:  ",
    //               subTitle: widget.patienSummryData.pBillNo ?? "",
    //               style: TextStyle(
    //                 fontSize: 14.sp,
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //             Spacer(),
    //             _nameUi(
    //               title: "",
    //               subTitle:
    //                   widget.patienSummryData.pathDate?.toFormattedString() ??
    //                       "",
    //               style: TextStyle(
    //                 fontSize: 14.sp,
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //             FxBox.w8,
    //             Image.asset(
    //               widget.patienSummryData.isCompleted == true
    //                   ? Images.completed
    //                   : Images.pending,
    //               height: 25.h,
    //             ),
    //             FxBox.w8,
    //             InkWell(
    //                 onTap: () {
    //                   whatsAppOpen(
    //                       context: context, message: "Testing Message..");
    //                 },
    //                 child: Icon(Icons.share_rounded)),
    //             FxBox.w8,
    //           ],
    //         ),
    //         FxBox.h10,
    //         _nameUi(
    //           title: "Test Name:  ",
    //           subTitle: widget.patienSummryData.testName ?? "",
    //           style: TextStyle(
    //             fontSize: 16.sp,
    //             fontWeight: FontWeight.w500,
    //           ),
    //         ),
    //         FxBox.h10,
    //       ],
    //     ),
    //   ),
    // );
    return Card(
      elevation: 4.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bill No: ${widget.patienSummryData.pBillNo ?? ""}',
                  style:
                      TextStyle(fontSize: 15.0.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.patienSummryData.pathDate?.toFormattedString() ?? "",
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            if (widget.patienSummryData.testName?.isNotEmpty ?? false) ...[
              SizedBox(height: 8.0),
              Text(
                widget.patienSummryData.testName ?? "",
                style: TextStyle(
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            FxBox.h10,
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.hourglass_bottom,
                      color: Colors.blue,
                    ),
                    onTap: () {},
                  ),
                  FxBox.w2,
                  VerticalDivider(),
                  FxBox.w2,
                  AnimatedButton(isCard: false)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _nameUi(
  //     {required String title, required String subTitle, TextStyle? style}) {
  //   return Row(
  //     children: [
  //       Text(
  //         title,
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 15.sp,
  //         ),
  //       ),
  //       Text(
  //         subTitle,
  //         style: style ??
  //             TextStyle(
  //               fontWeight: FontWeight.w600,
  //               fontSize: 17.sp,
  //             ),
  //       ),
  //     ],
  //   );
  // }
}
