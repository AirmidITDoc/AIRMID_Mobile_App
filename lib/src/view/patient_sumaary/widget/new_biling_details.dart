import 'dart:developer';

import 'package:airmid/src/model/pation_summry/billing.dart';
import 'package:airmid/src/provider/bolc/patient_summry/biling/biling_bloc_bloc.dart';
import 'package:airmid/src/provider/bolc/patient_summry/bloc/biling_details_bloc.dart';
import 'package:airmid/src/view/patient_sumaary/widget/biling_data.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:airmid/src/utils/extantion.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Demo extends StatefulWidget {
  final int opIpType;
  final int opdIpdId;
  const Demo({super.key, required this.opIpType, required this.opdIpdId});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final BilingBlocBloc _bilingSummryBloc = BilingBlocBloc();
  final BilingDetailsBloc _bilingDetailsBloc = BilingDetailsBloc();
  int? selected;
  @override
  void initState() {
    _bilingSummryBloc
        .add(BilingBlocEvent.started(widget.opIpType, widget.opdIpdId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _bilingSummryBloc),
        BlocProvider(create: (context) => _bilingDetailsBloc),
      ],
      child: BlocBuilder<BilingBlocBloc, BilingBlocState>(
        builder: (context, state) {
          return state.when(
              error: (message) => Center(child: Text(message)),
              initial: () => SizedBox.shrink(),
              loading: () => Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
              success: (bilingBlogData) {
                if (bilingBlogData.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("No Data Found"),
                      ),
                    ],
                  );
                } else {
                  return ListView.builder(
                    key: Key('builder ${selected.toString()}'), //attention
                    itemCount: bilingBlogData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 5,
                          color: Colors.white,
                          shadowColor: Colors.white,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              childrenPadding: EdgeInsets.zero,
                              initiallyExpanded: index == selected,
                              key: Key(index.toString()),
                              trailing: SizedBox.shrink(),
                              onExpansionChanged: (bool expanded) {
                                setState(() {
                                  // if (expanded) {
                                  //   _expandedIndex = index;
                                  // _bilingDetailsBloc.add(
                                  //     BilingDetailsEvent.started(
                                  //         bilingBlogData[index].billNo ?? 0));
                                  // } else if (_expandedIndex == index) {
                                  //   _expandedIndex = -1;
                                  // }
                                  if (expanded) {
                                    setState(() {
                                      selected = index;
                                      log("Bill No: ${bilingBlogData[index].billNo}");
                                      _bilingDetailsBloc.add(
                                          BilingDetailsEvent.started(
                                              bilingBlogData[index].billNo ??
                                                  0));
                                    });
                                  } else {
                                    setState(() {
                                      selected = -1;
                                    });
                                  }
                                });
                              },
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: Row(
                                  children: [
                                    _nameUi(
                                      title: "Bill No:  ",
                                      subTitle:
                                          bilingBlogData[index].pBillNo ?? "",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Spacer(),
                                    _nameUi(
                                      title: "",
                                      subTitle: bilingBlogData[index]
                                              .billDate
                                              ?.toFormattedString() ??
                                          "",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FxBox.h16,
                                    // _table(
                                    //   title: "Bill Amount",
                                    //   data:
                                    //       "₹${bilingBlogData[index].billAmount.toString()}",
                                    // ),
                                    // FxBox.h4,
                                    // _table(
                                    //   title: "Discount %",
                                    //   data:
                                    //       "${bilingBlogData[index].discAmount.toString()}",
                                    // ),
                                    // FxBox.h4,
                                    _table(
                                      context: context,
                                      bilingData: bilingBlogData[index],
                                      title: "Net. Amount",
                                      data:
                                          "₹ ${bilingBlogData[index].netAmount.toString()}",
                                    ),

                                    // FxBox.h4,
                                    // if (bilingBlogData[index].chequePay !=
                                    //     0.0) ...[
                                    //   FxBox.h4,
                                    //   _table(
                                    //     title: "ChequePay",
                                    //     data:
                                    //         "₹ ${bilingBlogData[index].chequePay.toString()}",
                                    //   ),
                                    // ],
                                    // if (bilingBlogData[index].cardPay !=
                                    //     0.0) ...[
                                    //   FxBox.h4,
                                    //   _table(
                                    //     title: "CardPay",
                                    //     data:
                                    //         "₹ ${bilingBlogData[index].cardPay.toString()}",
                                    //   ),
                                    // ],
                                    // if (bilingBlogData[index].cashPay !=
                                    //     0.0) ...[
                                    //   FxBox.h4,
                                    //   _table(
                                    //     title: "CashPay",
                                    //     data:
                                    //         "₹ ${bilingBlogData[index].cashPay.toString()}",
                                    //   ),
                                    // ],
                                    // if (bilingBlogData[index].onlinePay !=
                                    //     0.0) ...[
                                    //   FxBox.h4,
                                    //   _table(
                                    //     title: "OnlinePay",
                                    //     data:
                                    //         "₹ ${bilingBlogData[index].onlinePay.toString()}",
                                    //   ),
                                    // ],
                                    // if (bilingBlogData[index].paidAmount !=
                                    //     0.0) ...[
                                    //   FxBox.h4,
                                    //   _table(
                                    //     title: "PaidAmount",
                                    //     data:
                                    //         "₹ ${bilingBlogData[index].paidAmount.toString()}",
                                    //   ),
                                    // ],
                                  ],
                                ),
                              ),
                              children: <Widget>[
                                BlocBuilder<BilingDetailsBloc,
                                    BilingDetailsState>(
                                  builder: (context, state) {
                                    return state.when(
                                      initial: () => SizedBox.shrink(),
                                      loading: () => Center(
                                          child: CircularProgressIndicator
                                              .adaptive()),
                                      success: (bilingDetails) {
                                        return BillDetails(
                                            bilingDetails:
                                                bilingBlogData[index],
                                            bilingDetailsData: bilingDetails);
                                        // return ListView.builder(
                                        //   shrinkWrap: true,
                                        //   physics: NeverScrollableScrollPhysics(),
                                        //   itemCount: bilingDetails.length,
                                        //   itemBuilder: (context, index) {
                                        //     return Padding(
                                        //       padding: const EdgeInsets.symmetric(
                                        //               horizontal: 10.0,
                                        //               vertical: 8.0)
                                        //           .r,
                                        //       child: Card(
                                        //         color: Colors.white,
                                        //         elevation: 4,
                                        //         shape: RoundedRectangleBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(15),
                                        //         ),
                                        //         child: Padding(
                                        //           padding:
                                        //               const EdgeInsets.all(16.0),
                                        //           child: Column(
                                        //             crossAxisAlignment:
                                        //                 CrossAxisAlignment.start,
                                        //             children: [
                                        //               if (bilingDetails[index]
                                        //                       .serviceName !=
                                        //                   null) ...[
                                        //                 _buildDetailRow(
                                        //                   icon: Icons
                                        //                       .medical_services,
                                        //                   label: 'Service Name:',
                                        //                   value: bilingDetails[
                                        //                               index]
                                        //                           .serviceName ??
                                        //                       "",
                                        //                 ),
                                        //               ],
                                        //               if (bilingDetails[index]
                                        //                       .price !=
                                        //                   null) ...[
                                        //                 _buildDetailRow(
                                        //                   icon:
                                        //                       Icons.attach_money,
                                        //                   label: 'Price:',
                                        //                   value:
                                        //                       '₹ ${bilingDetails[index].price}',
                                        //                 ),
                                        //               ],
                                        //               if (bilingDetails[index]
                                        //                       .qty !=
                                        //                   null) ...[
                                        //                 _buildDetailRow(
                                        //                   icon: Icons
                                        //                       .format_list_numbered,
                                        //                   label: 'Quantity:',
                                        //                   value:
                                        //                       bilingDetails[index]
                                        //                           .qty
                                        //                           .toString(),
                                        //                 ),
                                        //               ],
                                        //               if (bilingDetails[index]
                                        //                           .totalAmt !=
                                        //                       null &&
                                        //                   bilingDetails[index]
                                        //                           .netAmount !=
                                        //                       null) ...[
                                        //                 Divider(),
                                        //               ],
                                        //               if (bilingDetails[index]
                                        //                       .totalAmt !=
                                        //                   null) ...[
                                        //                 _buildDetailRow(
                                        //                   icon: Icons.money,
                                        //                   label: 'Total Amount:',
                                        //                   value:
                                        //                       '₹ ${bilingDetails[index].totalAmt}',
                                        //                 ),
                                        //               ],
                                        //               if (bilingDetails[index]
                                        //                       .netAmount !=
                                        //                   null) ...[
                                        //                 _buildDetailRow(
                                        //                   icon: Icons.money_off,
                                        //                   label: 'Net Amount:',
                                        //                   value:
                                        //                       '${bilingDetails[index].netAmount}',
                                        //                 ),
                                        //               ],
                                        //               if (bilingDetails[index]
                                        //                       .doctorName !=
                                        //                   null) ...[
                                        //                 Divider(),
                                        //                 _buildDetailRow(
                                        //                   icon: Icons.person,
                                        //                   label: 'Doctor Name:',
                                        //                   value: bilingDetails[
                                        //                               index]
                                        //                           .doctorName ??
                                        //                       '',
                                        //                 ),
                                        //               ],
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     );
                                        //   },
                                        // );
                                      },
                                      error: (message) {
                                        return Center(
                                          child: Text(message),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              });
        },
      ),
    );
  }
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

Widget _table(
    {required String title,
    required String data,
    required BilingData bilingData,
    required BuildContext context}) {
  return SizedBox(
    width: MediaQuery.sizeOf(context).width,
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\₹${bilingData.netAmount}',
              style: TextStyle(
                fontSize: 22.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            FxBox.h10,
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cash",
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      FxBox.h8,
                      Text(
                        '\₹${bilingData.cashPay}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  VerticalDivider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Card",
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      FxBox.h8,
                      Text(
                        '\₹${bilingData.cardPay}',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  VerticalDivider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Online",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FxBox.h8,
                      Text(
                        '\₹${bilingData.onlinePay}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
