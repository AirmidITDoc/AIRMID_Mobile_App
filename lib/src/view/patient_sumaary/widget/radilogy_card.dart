import 'package:airmid/src/model/pation_summry/radailogy.dart';
import 'package:airmid/src/utils/extantion.dart';
import 'package:airmid/src/widget/animated_button.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadilogyCardData extends StatefulWidget {
  final RadiologyList radiologyList;
  const RadilogyCardData({super.key, required this.radiologyList});

  @override
  State<RadilogyCardData> createState() => _RadilogyCardDataState();
}

class _RadilogyCardDataState extends State<RadilogyCardData> {
  @override
  Widget build(BuildContext context) {
    // return Card(
    //   elevation: 3,
    //   color: Color(0xffFAFAFF),
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15).r,
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Row(
    //           children: [
    //             _nameUi(
    //               title: "Bill No:  ",
    //               subTitle: widget.radiologyList.pBillNo ?? "",
    //               style: TextStyle(
    //                 fontSize: 14.sp,
    //                 fontWeight: FontWeight.w600,
    //               ),
    //             ),
    //             Spacer(),
    //             _nameUi(
    //               title: "",
    //               subTitle: widget.radiologyList.radTime.toFormattedString(),
    //               style: TextStyle(
    //                 fontSize: 14.sp,
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //           ],
    //         ),
    //         if (widget.radiologyList.testName?.isNotEmpty ?? false) ...[
    //           FxBox.h4,
    //           _nameUi(title: "", subTitle: widget.radiologyList.testName ?? ""),
    //         ],
    //         FxBox.h16,
    //         Center(
    //           child: Container(
    //             width: 150.w,
    //             decoration: BoxDecoration(
    //               color: Color(0xFFFE0E7FF),
    //               // color: Color(0xFFE0E7FF),
    //               // color: Color(0xFFF0F0F0),
    //               borderRadius: BorderRadius.circular(16),
    //             ),
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(vertical: 8.0),
    //               child: IntrinsicHeight(
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Image.asset(
    //                       widget.radiologyList.isCompleted == true
    //                           ? Images.completed
    //                           : Images.pending,
    //                       height: 22.h,
    //                     ),
    //                     VerticalDivider(color: Colors.black54),
    //                     InkWell(
    //                       onTap: () {
    //                         whatsAppOpen(
    //                           context: context,
    //                           message: "Testing Message..",
    //                         );
    //                       },
    //                       child: Icon(
    //                         Icons.share,
    //                         size: 22,
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
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
                  'Bill No: ${widget.radiologyList.pBillNo ?? ""}',
                  style:
                      TextStyle(fontSize: 15.0.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.radiologyList.radTime.toFormattedString(),
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            if (widget.radiologyList.testName?.isNotEmpty ?? false) ...[
              SizedBox(height: 8.0),
              Text(
                widget.radiologyList.testName ?? "",
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
                  AnimatedButton(isCard: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
