import 'package:airmid/src/model/pation_summry/biling_details.dart';
import 'package:airmid/src/model/pation_summry/billing.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillDetails extends StatefulWidget {
  final BilingData bilingDetails;

  final List<BilingDetailsModel> bilingDetailsData;

  const BillDetails(
      {super.key,
      required this.bilingDetailsData,
      required this.bilingDetails});
  @override
  State<BillDetails> createState() => _BillDetailsState();
}

class _BillDetailsState extends State<BillDetails> {
  int totalPrice = 0;
  int totalNetAmout = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FxBox.h12,
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Biling Details",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Padding(
        //     padding:
        //         const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
        //     child: DataTable(
        //       border: TableBorder.all(color: Colors.black, width: 0.5),
        //       columns: [
        //         DataColumn(label: Text('Sr. No')),
        //         DataColumn(label: Text('Service Name')),
        //         DataColumn(label: Text('Doctor Name')),
        //         DataColumn(label: Text('Price')),
        //         DataColumn(label: Text('Qty')),
        //         DataColumn(label: Text('Net Amount')),
        //       ],
        //       rows: widget.bilingDetailsData.map((item) {
        //         return DataRow(cells: [
        //           DataCell(Text(
        //               (widget.bilingDetailsData.indexOf(item) + 1).toString())),
        //           DataCell(Text(item.serviceName.toString())),
        //           DataCell(
        //               Text(item.doctorName != null ? item.doctorName : "")),
        //           DataCell(Text(item.price.toString())),
        //           DataCell(Text(item.qty.toString())),
        //           DataCell(Text(item.netAmount.toString())),
        //         ]);
        //       }).toList(),
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         'Bill Details',
        //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 16),
        //       Table(
        //         border: TableBorder.all(),
        //         columnWidths: {
        //           0: FlexColumnWidth(1),
        //           1: FlexColumnWidth(3),
        //           2: FlexColumnWidth(1),
        //           3: FlexColumnWidth(1),
        //           4: FlexColumnWidth(1),
        //         },
        //         children: [
        //           TableRow(
        //             children: [
        //               TableCell(
        //                   child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text('Sr. No',
        //                     style: TextStyle(fontWeight: FontWeight.bold)),
        //               )),
        //               TableCell(
        //                   child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text('Service Name',
        //                     style: TextStyle(fontWeight: FontWeight.bold)),
        //               )),
        //               TableCell(
        //                   child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text('Price',
        //                     style: TextStyle(fontWeight: FontWeight.bold)),
        //               )),
        //               TableCell(
        //                   child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text('Qty',
        //                     style: TextStyle(fontWeight: FontWeight.bold)),
        //               )),
        //               TableCell(
        //                   child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text('Net Amount',
        //                     style: TextStyle(fontWeight: FontWeight.bold)),
        //               )),
        //             ],
        //           ),
        //           for (int i = 0; i < widget.bilingDetailsData.length; i++)
        //             TableRow(
        //               children: [
        //                 TableCell(
        //                     child: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Text((i + 1).toString()),
        //                 )),
        //                 TableCell(
        //                     child: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Text(
        //                       widget.bilingDetailsData[i].serviceName ?? ""),
        //                 )),
        //                 TableCell(
        //                     child: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Text(
        //                       widget.bilingDetailsData[i].price.toString()),
        //                 )),
        //                 TableCell(
        //                     child: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child:
        //                       Text(widget.bilingDetailsData[i].qty.toString()),
        //                 )),
        //                 TableCell(
        //                     child: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Text(
        //                       widget.bilingDetailsData[i].netAmount.toString()),
        //                 )),
        //               ],
        //             ),
        //         ],
        //       ),
        //       SizedBox(height: 16),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text('Total Bill Amount:'),
        //           Text(widget.bilingDetailsData
        //               .where((item) => item.netAmount is num)
        //               .fold(0, (sum, item) => sum + 10)
        //               .toInt()
        //               .toString()),
        //         ],
        //       ),
        //       Divider(),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text('Paid Amount:'),
        //           Text('1450'),
        //         ],
        //       ),
        //       Divider(),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text('Net Amount:'),
        //           Text('1450'),
        //         ],
        //       ),
        //       // Divider(),
        //       // SizedBox(height: 16),
        //       // Text(
        //       //   'Total Amount in words: ONE THOUSAND FOUR HUNDRED AND FIFTY RUPEES ONLY',
        //       //   style: TextStyle(fontWeight: FontWeight.bold),
        //       // ),
        //       // SizedBox(height: 16),
        //       // Text(
        //       //   'This is a computer generated invoice hence doesn\'t require signature',
        //       //   style: TextStyle(fontStyle: FontStyle.italic),
        //       // ),
        //       // SizedBox(height: 16),
        //       // Align(
        //       //   alignment: Alignment.centerRight,
        //       //   child: Text('ADMIN ADMIN'),
        //       // ),
        //       // Align(
        //       //   alignment: Alignment.centerRight,
        //       //   child: Text('Generated By'),
        //       // ),
        //     ],
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Table(
            border: TableBorder.all(
              color: Colors.black45,
            ),
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Service Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Net Amount',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              for (var service in widget.bilingDetailsData)
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.serviceName ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              service.doctorName ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              service.netAmount.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        FxBox.h10,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Bill Amount:',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    "${calculateBillNetAmount()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount:',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    "0",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Net Amount:',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    "${calculateTotalNetAmount()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Paid Amount:',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    widget.bilingDetails.netAmount.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Function to calculate total net amount
  double calculateTotalNetAmount() {
    double totalNetAmount = 0;
    widget.bilingDetailsData.forEach((item) {
      totalNetAmount += item.netAmount ?? 0.0;
    });

    return totalNetAmount;
  }

  double calculateBillNetAmount() {
    double totalPriceAmount = 0;
    widget.bilingDetailsData.forEach((item) {
      totalPriceAmount += item.price ?? 0.0;
    });

    return totalPriceAmount;
  }
}
