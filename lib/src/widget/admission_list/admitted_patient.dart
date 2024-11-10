import 'package:airmid/src/constant/image.dart';
import 'package:airmid/src/model/admission_list/appoinment_model.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class AdmittedPatientCard extends StatefulWidget {
  final int index;
  final void Function() onTap;
  final List<AdmitListData> admittedData;
  const AdmittedPatientCard(
      {super.key,
      required this.index,
      required this.onTap,
      required this.admittedData});

  @override
  State<AdmittedPatientCard> createState() => _AdmittedPatientCardState();
}

class _AdmittedPatientCardState extends State<AdmittedPatientCard> {
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
                            Column(
                              children: [
                                Card(
                                  color: Colors.white,
                                  elevation: 1,
                                  child: Container(
                                    height: 70.h,
                                    width: 70.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12).r,
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        Images.patientList,
                                        height: 50.h,
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0).r,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: 22.sp,
                                        ),
                                        FxBox.w4,
                                        Text(
                                            "${widget.admittedData[widget.index].ageYear ?? ""}")
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            VerticalDivider(
                              endIndent: 2,
                              indent: 2,
                            ),
                            FxBox.w6,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _nameUi(
                                      title: "",
                                      subTitle:
                                          "${widget.admittedData[widget.index].regNo ?? ""} | ${widget.admittedData[widget.index].patientName ?? ""}"),
                                  if (widget.admittedData[widget.index]
                                          .doctorName !=
                                      null) ...[
                                    FxBox.h2,
                                    _nameUi(
                                      title: "",
                                      subTitle:
                                          "${widget.admittedData[widget.index].doctorName ?? ""}",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                  ],
                                  if (widget.admittedData[widget.index].ipdNo !=
                                      null) ...[
                                    FxBox.h2,
                                    _nameUi(
                                      title: "",
                                      subTitle:
                                          "${widget.admittedData[widget.index].ipdNo ?? ""}",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                  ],
                                  if (widget.admittedData[widget.index].doa !=
                                      null) ...[
                                    FxBox.h2,
                                    _nameUi(
                                      title: "",
                                      subTitle:
                                          "${DateFormat('dd-mm-yyyy hh:mm a').format(widget.admittedData[widget.index].doa!)}",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                  ],
                                  if (widget.admittedData[widget.index]
                                          .refDoctorName !=
                                      null) ...[
                                    FxBox.h10,
                                    _nameUi(
                                      title: "",
                                      subTitle:
                                          "${widget.admittedData[widget.index].refDoctorName ?? ""}",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                  ],
                                  if (widget.admittedData[widget.index]
                                          .companyName !=
                                      null) ...[
                                    FxBox.h2,
                                    _nameUi(
                                      title: "",
                                      subTitle:
                                          "${widget.admittedData[widget.index].companyName ?? ""}",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      FxBox.h10,
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
                              "${widget.admittedData[widget.index].wardName}| ",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.sp,
                              ),
                            ),
                            Text(
                              " ${widget.admittedData[widget.index].bedName}",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.sp,
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
