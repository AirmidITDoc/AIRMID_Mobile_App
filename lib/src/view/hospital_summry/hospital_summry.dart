import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/hospital_summry/hospital_summry.dart';
import 'package:airmid/src/provider/bolc/hospital_summry/pharmasy_store/pharmasy_store_list_bloc.dart';
import 'package:airmid/src/provider/bolc/hospital_summry/hospital_pharmasy_summry/hospital_pharmacy_summry_bloc.dart';
import 'package:airmid/src/provider/bolc/hospital_summry/hospital_summry/hospitalsummry_bloc.dart';
import 'package:airmid/src/view/hospital_summry/barchart.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalSummry extends StatefulWidget {
  const HospitalSummry({super.key});

  @override
  State<HospitalSummry> createState() => _HospitalSummryState();
}

class _HospitalSummryState extends State<HospitalSummry> {
  HospitalsummryBloc _hospitalsummryBloc = HospitalsummryBloc();
  PharmasyStoreListBloc _pharmasyStoreListBloc = PharmasyStoreListBloc();
  HospitalPharmacySummryBloc _hospitalPharmacySummryBloc =
      HospitalPharmacySummryBloc();
  final TextEditingController _storeController = TextEditingController();
  final TextEditingController _storeSearchController = TextEditingController();
  @override
  void initState() {
    _hospitalsummryBloc.add(HospitalsummryEvent.started());
    _pharmasyStoreListBloc.add(PharmasyStoreListEvent.started());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _hospitalsummryBloc.add(HospitalsummryEvent.started());
        _pharmasyStoreListBloc.add(PharmasyStoreListEvent.started());
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _hospitalsummryBloc),
          BlocProvider(create: (context) => _pharmasyStoreListBloc),
          BlocProvider(create: (context) => _hospitalPharmacySummryBloc),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.indigo,
            foregroundColor: Colors.indigo,
            shadowColor: Colors.indigo,
            backgroundColor: Colors.indigo,
            title: const Text(
              'Hospital Summary',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          body: BlocListener<PharmasyStoreListBloc, PharmasyStoreListState>(
            listener: (context, state) {
              state.whenOrNull(
                error: (message) => Center(
                  child: Text(message),
                ),
                success: (pharmacyStore) {
                  _hospitalPharmacySummryBloc.add(
                    HospitalPharmacySummryEvent.started(
                      "Todays",
                      pharmacyStore.first.storeId.toString(),
                    ),
                  );
                },
                loading: () =>
                    Center(child: CircularProgressIndicator.adaptive()),
              );
            },
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  BlocBuilder<HospitalsummryBloc, HospitalsummryState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => SizedBox.shrink(),
                        loading: () => Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        success: (hospitalSummry) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Overview',
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                FxBox.h10,
                                Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.all(8.0),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\₹${hospitalSummry.first.netCollection.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 22.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        FxBox.h10,
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Collection",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                FxBox.h8,
                                                Text(
                                                  '\₹${hospitalSummry.first.todayCollection.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Refund",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                FxBox.h8,
                                                Text(
                                                  '\₹${hospitalSummry.first.todaysRefund.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                FxBox.h20,
                                Text(
                                  'Details',
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                FxBox.h10,
                                Row(
                                  children: [
                                    Expanded(
                                      child: MetricCard(
                                        title: "OP Collection",
                                        amount:
                                            hospitalSummry.first.opCollection,
                                        // color: Colors.orange,
                                        icon: Icons.local_hospital,
                                      ),
                                    ),
                                    Expanded(
                                      child: MetricCard(
                                        title: "IP Collection",
                                        amount:
                                            hospitalSummry.first.ipCollection,
                                        // color: Colors.purple,
                                        icon: Icons.monetization_on,
                                      ),
                                    ),
                                  ],
                                ),
                                FxBox.h10,
                                Row(
                                  children: [
                                    Expanded(
                                      child: MetricCard(
                                        title: "OP Refund",
                                        amount: hospitalSummry.first.opRefund,
                                        color: Colors.red,
                                        icon: Icons.restore,
                                      ),
                                    ),
                                    Expanded(
                                      child: MetricCard(
                                        title: "IP Refund",
                                        amount: hospitalSummry.first.ipRefund,
                                        color: Colors.red,
                                        icon: Icons.undo,
                                      ),
                                    ),
                                  ],
                                ),
                                FxBox.h20,
                                PaymentBreakdownChart(
                                    hospitalSummryData: hospitalSummry.first)
                              ],
                            ),
                          );
                        },
                        error: (message) => Center(
                          child: Text(message),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<PharmasyStoreListBloc, PharmasyStoreListState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => SizedBox.shrink(),
                        loading: () =>
                            Center(child: CircularProgressIndicator.adaptive()),
                        success: (pharmacyStore) {
                          Map<String, String> storeNameToIdMap = {
                            for (var store in pharmacyStore)
                              store.storeName: store.storeId.toString()
                          };
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pharmacy store",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                FxBox.h16,
                                DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  hint: const Text(
                                    ConstString.storeName,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  value:
                                      pharmacyStore.first.storeName.toString(),
                                  items: pharmacyStore
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item.storeName.toString(),
                                            child: Text(
                                              item.storeName,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    _storeSearchController.clear();
                                    if (value != null) {
                                      String? storeId = storeNameToIdMap[value];
                                      if (storeId != null) {
                                        _storeController.text = storeId;
                                        if (_storeController.text.isNotEmpty) {
                                          _hospitalPharmacySummryBloc.add(
                                            HospitalPharmacySummryEvent.started(
                                              "Todays",
                                              _storeController.text,
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.only(right: 8),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  dropdownSearchData: DropdownSearchData(
                                    searchController: _storeSearchController,
                                    searchInnerWidgetHeight: 50,
                                    searchInnerWidget: Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 4,
                                        right: 8,
                                        left: 8,
                                      ),
                                      child: TextFormField(
                                        expands: true,
                                        maxLines: null,
                                        controller: _storeSearchController,
                                        decoration: InputDecoration(
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              _storeSearchController.clear();
                                            },
                                            child: Icon(Icons.clear),
                                          ),
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Search store',
                                          hintStyle:
                                              const TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    searchMatchFn: (item, searchValue) {
                                      return (item.child as Text)
                                          .data!
                                          .toString()
                                          .toLowerCase()
                                          .contains(searchValue);
                                    },
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        error: (message) => Center(child: Text(message)),
                      );
                    },
                  ),
                  BlocBuilder<HospitalPharmacySummryBloc,
                      HospitalPharmacySummryState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => SizedBox.shrink(),
                        loading: () => Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        success: (hospitalPharmacySummry) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Overview',
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                FxBox.h10,
                                Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.all(8.0),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\₹${hospitalPharmacySummry.first.netCollectionAmount == null ? 0 : hospitalPharmacySummry.first.netCollectionAmount}',
                                          style: TextStyle(
                                            fontSize: 22.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        FxBox.h10,
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Collection",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                FxBox.h8,
                                                Text(
                                                  '\₹${hospitalPharmacySummry.first.collectionAmount == null ? 0 : hospitalPharmacySummry.first.collectionAmount}',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Refund",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                FxBox.h8,
                                                Text(
                                                  '\₹${hospitalPharmacySummry.first.refundAmount}',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Center(
                                //   child: SizedBox(
                                //     height: 300,
                                //     child: BarChart(
                                //       BarChartData(
                                //         alignment: BarChartAlignment.spaceAround,
                                //         maxY: 800,
                                //         barTouchData:
                                //             BarTouchData(enabled: false),
                                //         titlesData: FlTitlesData(
                                //           leftTitles: AxisTitles(
                                //             sideTitles: SideTitles(
                                //                 showTitles: true,
                                //                 interval: 100,
                                //                 reservedSize: 40),
                                //           ),
                                //           bottomTitles: AxisTitles(
                                //             sideTitles: SideTitles(
                                //               showTitles: true,
                                //               getTitlesWidget:
                                //                   (double value, TitleMeta meta) {
                                //                 switch (value.toInt()) {
                                //                   case 0:
                                //                     return Text('CashPay');
                                //                   case 1:
                                //                     return Text('ChequePay');
                                //                   case 2:
                                //                     return Text('OnlinePay');
                                //                   default:
                                //                     return Text('');
                                //                 }
                                //               },
                                //             ),
                                //           ),
                                //         ),
                                //         borderData: FlBorderData(show: false),
                                //         barGroups: [
                                //           BarChartGroupData(
                                //             x: 0,
                                //             barRods: [
                                //               BarChartRodData(
                                //                 toY: hospitalPharmacySummry
                                //                             .first.cashPay ==
                                //                         null
                                //                     ? 0.0
                                //                     : double.parse(
                                //                         hospitalPharmacySummry
                                //                             .first.cashPay
                                //                             .toString()),
                                //                 color: Colors.blue,
                                //                 width: 20,
                                //               )
                                //             ],
                                //           ),
                                //           BarChartGroupData(
                                //             x: 1,
                                //             barRods: [
                                //               BarChartRodData(
                                //                 toY: hospitalPharmacySummry
                                //                             .first.chequePay ==
                                //                         null
                                //                     ? 0.0
                                //                     : double.parse(
                                //                         hospitalPharmacySummry
                                //                             .first.chequePay
                                //                             .toString()),
                                //                 color: Colors.red,
                                //                 width: 20,
                                //               )
                                //             ],
                                //           ),
                                //           BarChartGroupData(
                                //             x: 2,
                                //             barRods: [
                                //               BarChartRodData(
                                //                   toY: hospitalPharmacySummry
                                //                               .first.onlinePay ==
                                //                           null
                                //                       ? 0.0
                                //                       : double.parse(
                                //                           hospitalPharmacySummry
                                //                               .first.onlinePay
                                //                               .toString())),
                                //             ],
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                FxBox.h40,
                                Text(
                                  "Collection",
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                FxBox.h10,
                                SizedBox(
                                  child: Card(
                                    elevation: 3,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FxBox.h12,
                                          SizedBox(
                                            width: double.infinity,
                                            height: 200,
                                            child: ChartJsBarChart(
                                              hospitalSummryData:
                                                  hospitalPharmacySummry.first,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                FxBox.h40,
                              ],
                            ),
                          );
                        },
                        error: (message) => Center(
                          child: Text(message),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final String title;
  final double amount;
  final Color? color;
  final IconData? icon;

  MetricCard(
      {required this.title, required this.amount, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (icon != null) ...[
            //   Icon(icon, color: color, size: 30.sp),
            //   FxBox.h8,
            // ],
            Text(
              '\₹${amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            FxBox.h4,
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                color: color ?? Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
            FxBox.h4,
          ],
        ),
      ),
    );
  }
}

class PaymentBreakdownChart extends StatefulWidget {
  final HospitalSummryModel hospitalSummryData;

  PaymentBreakdownChart({required this.hospitalSummryData});

  @override
  State<PaymentBreakdownChart> createState() => _PaymentBreakdownChartState();
}

class _PaymentBreakdownChartState extends State<PaymentBreakdownChart> {
  int? touchedIndex;
  String? tooltipMessage;
  double get totalPayments =>
      widget.hospitalSummryData.cashPay +
      widget.hospitalSummryData.chequePay +
      widget.hospitalSummryData.online;
  @override
  Widget build(BuildContext context) {
    return Card(
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
              'Payment Breakdown',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            FxBox.h10,
            Container(
              height: 250.h,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      sections: showingSections(),
                      sectionsSpace: 4,
                      centerSpaceRadius: 0,
                      borderData: FlBorderData(show: false),
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              tooltipMessage = null;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                            final touchedSection =
                                showingSections()[touchedIndex ?? 0];
                            tooltipMessage =
                                '${touchedSection.title}: ${touchedSection.value.toStringAsFixed(1)}%';
                          });
                        },
                      ),
                    ),
                  ),
                  if (tooltipMessage != null) ...{
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Tooltip(
                        message: tooltipMessage!,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            tooltipMessage!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    )
                  },
                ],
              ),
            ),
            FxBox.h20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LegendItem(color: Colors.blue, text: 'Cash'),
                LegendItem(color: Colors.green, text: 'Cheque'),
                LegendItem(color: Colors.orange, text: 'Online'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 16.sp : 14.sp;
      final double radius = isTouched ? 120.r : 110.r;

      switch (i) {
        case 0:
          final value = widget.hospitalSummryData.cashPay;
          final percentage = (value / totalPayments * 100).toStringAsFixed(1);
          return PieChartSectionData(
            // titlePositionPercentageOffset: value == 100 ? null : 0,
            value: value,
            title: '${percentage}%\n${widget.hospitalSummryData.cashPay}',
            color: Colors.blue,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        case 1:
          final value = widget.hospitalSummryData.chequePay;
          final percentage = (value / totalPayments * 100).toStringAsFixed(1);
          return PieChartSectionData(
            // titlePositionPercentageOffset: value == 100 ? null : 0,
            value: value,
            title: '${percentage}%\n${widget.hospitalSummryData.chequePay}',
            color: Colors.green,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        case 2:
          final value = widget.hospitalSummryData.online;
          final percentage = (value / totalPayments * 100).toStringAsFixed(1);

          return PieChartSectionData(
            // titlePositionPercentageOffset: value == 100 ? null : 0,
            value: value,
            title: value > totalPayments * 0.05
                ? '${percentage}%\n${widget.hospitalSummryData.online}'
                : '',
            color: Colors.orange,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        FxBox.w8,
        Text(
          text,
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    );
  }
}

class HospitalSummryModelData {
  final double cashPay;
  final double chequePay;
  final double online;

  HospitalSummryModelData({
    required this.cashPay,
    required this.chequePay,
    required this.online,
  });
}
