import 'dart:developer';

import 'package:airmid/src/constant/color.dart';
import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/provider/bolc/patient_summry/biling/biling_bloc_bloc.dart';
import 'package:airmid/src/provider/bolc/patient_summry/pathalogy/pathology_bloc.dart';
import 'package:airmid/src/provider/bolc/patient_summry/radilogy/radilogy_bloc.dart';
import 'package:airmid/src/view/patient_sumaary/widget/new_biling_details.dart';
import 'package:airmid/src/view/patient_sumaary/widget/pathology_card.dart';
import 'package:airmid/src/view/patient_sumaary/widget/radilogy_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientSumaary extends StatefulWidget {
  final int opIpType;
  final int opdIpdId;
  final String patientName;
  const PatientSumaary({
    super.key,
    required this.opIpType,
    required this.opdIpdId,
    required this.patientName,
  });

  @override
  State<PatientSumaary> createState() => _PatientSumaaryState();
}

class _PatientSumaaryState extends State<PatientSumaary>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PathologyBloc _pationSummryBloc = PathologyBloc();
  final BilingBlocBloc _bilingSummryBloc = BilingBlocBloc();
  final RadilogyBloc _radilogySummryBloc = RadilogyBloc();
  @override
  void initState() {
    log("opIp ${widget.opIpType}");
    log("opdIpdId ${widget.opdIpdId}");
    _tabController = TabController(length: 4, vsync: this);
    _pationSummryBloc
        .add(PathologyEvent.started(widget.opIpType, widget.opdIpdId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _pationSummryBloc),
        BlocProvider(create: (context) => _bilingSummryBloc),
        BlocProvider(create: (context) => _radilogySummryBloc),
      ],
      child: Scaffold(
        backgroundColor: Color(0xffFAFAFF),
        body: Scaffold(
          backgroundColor: Color(0xffFAFAFF),
          appBar: AppBar(
            leading: BackButton(color: Colors.white),
            surfaceTintColor: Colors.indigo,
            foregroundColor: Colors.indigo,
            shadowColor: Colors.indigo,
            backgroundColor: Colors.indigo,
            title: Text(
              widget.patientName,
              style: TextStyle(
                color: ConstColor.white,
              ),
            ),
            bottom: TabBar(
              onTap: (int index) {
                log("Tab index $index");
                index == 0
                    ? _pationSummryBloc.add(PathologyEvent.started(
                        widget.opIpType, widget.opdIpdId))
                    : index == 1
                        ? _radilogySummryBloc.add(RadilogyEvent.started(
                            widget.opIpType, widget.opdIpdId))
                        : index == 2
                            ? _pationSummryBloc.add(PathologyEvent.started(
                                widget.opIpType, widget.opdIpdId))
                            : _bilingSummryBloc.add(BilingBlocEvent.started(
                                widget.opIpType, widget.opdIpdId));
              },
              indicatorPadding: EdgeInsets.zero,
              tabAlignment: TabAlignment.start,
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(),
              isScrollable: true,
              labelColor: ConstColor.white,
              unselectedLabelColor: Colors.white,
              dividerColor: Colors.transparent,
              indicatorColor: ConstColor.white,
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Text(ConstString.pathology),
                ),
                Tab(
                  icon: Text(ConstString.radiology),
                ),
                Tab(
                  icon: Text(ConstString.prescription),
                ),
                Tab(
                  icon: Text(ConstString.billing),
                ),
              ],
            ),
          ),
          body: DefaultTabController(
            length: 4,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<PathologyBloc, PathologyState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => SizedBox.shrink(),
                        loading: () => Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        success: (patienSummryData) {
                          if (patienSummryData.isEmpty) {
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
                              itemCount: patienSummryData.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: PathologyCardData(
                                    patienSummryData: patienSummryData[index],
                                  ),
                                );
                              },
                            );
                          }
                        },
                        error: (error) {
                          return Center(child: Text(error));
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<RadilogyBloc, RadilogyState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => SizedBox.shrink(),
                        loading: () => Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        success: (radiologySummryData) {
                          if (radiologySummryData.isEmpty) {
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
                              itemCount: radiologySummryData.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: RadilogyCardData(
                                    radiologyList: radiologySummryData[index],
                                  ),
                                );
                              },
                            );
                          }
                        },
                        error: (message) {
                          return Center(child: Text(message));
                        },
                      );
                    },
                  ),
                ),
                Center(child: Text('No Data Found')),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: BlocBuilder<BilingBlocBloc, BilingBlocState>(
                //     builder: (context, state) {
                //       return state.when(
                //         initial: () => SizedBox.shrink(),
                //         loading: () => Center(
                //           child: CircularProgressIndicator.adaptive(),
                //         ),
                //         success: (bilingBlogData) {
                //           if (bilingBlogData.isEmpty) {
                //             return Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children: [
                //                 Center(
                //                   child: Text("No Data Found"),
                //                 ),
                //               ],
                //             );
                //           } else {
                //             return ListView.builder(
                //               itemCount: bilingBlogData.length,
                //               itemBuilder: (context, index) {
                //                 return Padding(
                //                   padding: const EdgeInsets.only(bottom: 20.0),
                //                   child: BilingCardData(
                //                     bilingDataSummryData: bilingBlogData[index],
                //                   ),
                //                 );
                //               },
                //             );
                //           }
                //         },
                //         error: (error) {
                //           return Center(child: Text(error));
                //         },
                //       );
                //     },
                //   ),
                // ),
                Demo(
                  opIpType: widget.opIpType,
                  opdIpdId: widget.opdIpdId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
