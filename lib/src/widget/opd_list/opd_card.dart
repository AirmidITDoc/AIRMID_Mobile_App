import 'package:airmid/src/constant/image.dart';
import 'package:airmid/src/model/op_list/op_data_list.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class OpdCard extends StatefulWidget {
  final int index;
  final void Function() onTap;
  final List<OpDataList> opdData;
  const OpdCard(
      {super.key,
      required this.index,
      required this.onTap,
      required this.opdData});

  @override
  State<OpdCard> createState() => _OpdCardState();
}

class _OpdCardState extends State<OpdCard> {
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: widget.index,
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0).r,
            child: InkWell(
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: Color(0xffE3E3E3),
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0)
                      .r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Card(
                              color: Colors.white,
                              elevation: 1,
                              child: Container(
                                height: 80.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12).r,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    widget.opdData[widget.index].patientType ==
                                            "Self"
                                        ? Images.slefPatient
                                        : Images.companyPatient2,

                                    /// slef or compny logo behaf or compny type.
                                    height: 47.h,
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              endIndent: 8,
                              indent: 8,
                            ),
                            FxBox.w10,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _nameUi(
                                    title: "",
                                    subTitle:
                                        "${widget.opdData[widget.index].regNo} | ${widget.opdData[widget.index].patientName ?? ""}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (widget.opdData[widget.index].doctorName !=
                                      null) ...[
                                    FxBox.h2,
                                    _nameUi(
                                      title: "",
                                      subTitle:
                                          "${widget.opdData[widget.index].doctorName ?? ""}",
                                      style: TextStyle(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                  if (widget
                                          .opdData[widget.index].companyName !=
                                      null) ...[
                                    FxBox.h10,
                                    _nameUi(
                                        title: "",
                                        subTitle:
                                            "${widget.opdData[widget.index].companyName ?? ""}",
                                        style: TextStyle(
                                          color: Colors.black87,
                                        )),
                                  ],
                                  if (widget.opdData[widget.index].ageYear !=
                                      null) ...[
                                    FxBox.h8,
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                        ),
                                        FxBox.w10,
                                        Text(
                                          "${widget.opdData[widget.index].ageYear ?? ""}",
                                        ), // age
                                      ],
                                    )
                                  ],
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      FxBox.h4,
                      Divider(
                        color: Colors.black45,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                                left: 10, right: 10.0, bottom: 10, top: 5)
                            .r,
                        child: Row(
                          children: [
                            Text(
                              "${widget.opdData[widget.index].opdNo ?? ""}  | ",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.sp,
                              ),
                            ),
                            Text(
                              "${DateFormat('hh:mm a').format(DateTime.parse(widget.opdData[widget.index].visitDate.toString()))}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 22.sp,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
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
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
          ),
        ),
        Expanded(
          child: Text(
            subTitle,
            // maxLines: 1,
            // overflow: TextOverflow.ellipsis,
            style: style ??
                TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp,
                ),
          ),
        ),
      ],
    );
  }
}
