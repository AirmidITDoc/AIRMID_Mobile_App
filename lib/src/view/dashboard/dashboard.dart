import 'dart:developer';

import 'package:airmid/src/constant/color.dart';
import 'package:airmid/src/constant/const.dart';
import 'package:airmid/src/constant/image.dart';
import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/provider/bolc/dashboard_count/dashboard_count_bloc.dart';
import 'package:airmid/src/utils/hive/hive.dart';
import 'package:airmid/src/utils/responsive.dart';
import 'package:airmid/src/view/dashboard/pie_chart.dart';
import 'package:airmid/src/widget/dashboard/count_data.dart';
import 'package:airmid/src/widget/dashboard/profile_image.dart';
import 'package:airmid/src/widget/shimmer/list_shimmer.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:airmid/src/widget/top_snackbar/top_snackbar_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardCountBloc _dashboardCount = DashboardCountBloc();

  get success => null;
  @override
  void initState() {
    _dashboardCount.add(const DashboardCountEvent.started());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _dashboardCount,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.h,
          titleSpacing: 0,
          surfaceTintColor: Colors.indigo,
          foregroundColor: Colors.indigo,
          shadowColor: Colors.indigo,
          backgroundColor: Colors.indigo,
          centerTitle: false,
          leadingWidth: Responsive.isTablet(context) ? 50.w : 90.w,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 10.0).r,
            child: ProfileImage(
              profileImage: Images.dammyImage,
            ),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Hello,",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: Responsive.isTablet(context) ? 08.sp : 12.0.sp,
                      color: ConstColor.white,
                    ),
              ),
              Flexible(
                child: Text(
                  "${HiveUtils.get(HiveKeys.firstName) ?? ""} ${HiveUtils.get(HiveKeys.lastName) ?? ""}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize:
                            Responsive.isTablet(context) ? 12.sp : 18.0.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0).r,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocListener<DashboardCountBloc, DashboardCountState>(
                    listener: (context, state) {
                      state.whenOrNull(
                        loading: () => const ListShimmer(),
                        error: (message) {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(message: message),
                          );
                        },
                      );
                    },
                    child: Column(
                      children: [
                        BlocBuilder<DashboardCountBloc, DashboardCountState>(
                          builder: (context, state) {
                            return state.when(
                              initial: () => const SizedBox.shrink(),
                              loading: () => const ListShimmer(),
                              success: (dashboardData) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FxBox.h10,
                                    Text(
                                      ConstString.dashboard,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    FxBox.h8,
                                    GestureDetector(
                                      onTap: () {
                                        currentTab.value = 2;
                                      },
                                      child: CountData(
                                        count: dashboardData
                                            .first.appointmentCount
                                            .toString(),
                                        title: "Appoiment",
                                        image: Images.totleAppoiment,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        currentTab.value = 3;
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 6,
                                        child: Container(
                                          padding: const EdgeInsets.all(20),
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: IntrinsicHeight(
                                            child: Row(
                                              children: [
                                                Image(
                                                  height: 55.h,
                                                  image: const AssetImage(
                                                    Images.admitPatient,
                                                  ),
                                                ),
                                                const VerticalDivider(
                                                  endIndent: 3,
                                                  indent: 3,
                                                  color: Colors.black,
                                                  thickness: 0.5,
                                                ),
                                                FxBox.w10,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          ConstString
                                                              .admittedPatient,
                                                          style: TextStyle(
                                                            fontSize: 18.sp,
                                                          ),
                                                        ),
                                                        FxBox.w10,
                                                        Text(
                                                          dashboardData.first
                                                              .totalAdmittedPatientCount
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 24.sp,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Image(
                                                          height: 25.h,
                                                          image:
                                                              const AssetImage(
                                                            Images.todayPatient,
                                                          ),
                                                        ),
                                                        FxBox.w10,
                                                        Text(
                                                          dashboardData
                                                              .first.selfPatient
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 18.sp,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        FxBox.w20,
                                                        Image(
                                                          height: 25.h,
                                                          image:
                                                              const AssetImage(
                                                            Images
                                                                .companyPatient1,
                                                          ),
                                                        ),
                                                        FxBox.w10,
                                                        Text(
                                                          dashboardData.first
                                                              .compnayPatient
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 18.sp,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                      ),
                                    ),
                                    Card(
                                      color: Colors.white,
                                      elevation: 6,
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        width: MediaQuery.sizeOf(context).width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Image(
                                                height: 55.h,
                                                image: const AssetImage(
                                                  Images.todayAdminPatint,
                                                ),
                                              ),
                                              const VerticalDivider(
                                                endIndent: 3,
                                                indent: 3,
                                                color: Colors.black,
                                                thickness: 0.5,
                                              ),
                                              FxBox.w10,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        ConstString
                                                            .todayAdmitPatient,
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                        ),
                                                      ),
                                                      FxBox.w10,
                                                      Text(
                                                        dashboardData.first
                                                            .todayAdmittedPatient
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 24.sp,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image(
                                                        height: 25.h,
                                                        image: const AssetImage(
                                                          Images.patient,
                                                        ),
                                                      ),
                                                      FxBox.w10,
                                                      Text(
                                                        dashboardData.first
                                                            .todaySelfPatient
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      FxBox.w20,
                                                      Image(
                                                        height: 25.h,
                                                        image: const AssetImage(
                                                          Images.otherPatient,
                                                        ),
                                                      ),
                                                      FxBox.w10,
                                                      Text(
                                                        dashboardData.first
                                                            .todayOtherPatient
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                    ),
                                    CountData(
                                      count: dashboardData
                                          .first.todayDischargePatient
                                          .toString(),
                                      title: "Today Discharge Patient",
                                      image: Images.discharge,
                                    ),
                                    FxBox.h20,
                                    Text(
                                      "Chart",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: double.infinity,
                                      height: 300,
                                      child: PieChartExample(),
                                    ),
                                  ],
                                ).animate().fade();
                              },
                              error: (message) {
                                log("Dashboard Count Error: $message");
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
