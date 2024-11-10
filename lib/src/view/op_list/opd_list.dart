import 'dart:developer';
import 'package:airmid/src/constant/color.dart';
import 'package:airmid/src/provider/bolc/op_list/op_visitlist_blog/op_visit_list_blog_bloc.dart';
import 'package:airmid/src/view/op_list/add_apoiment.dart';
import 'package:airmid/src/view/patient_sumaary/patient_sumaary.dart';
import 'package:airmid/src/widget/opd_list/opd_card.dart';
import 'package:airmid/src/widget/shimmer/list_shimmer.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class OpdList extends StatefulWidget {
  const OpdList({super.key});

  @override
  State<OpdList> createState() => _OpdListState();
}

class _OpdListState extends State<OpdList> {
  final OpVisitListBlog _dashboardDataBloc = OpVisitListBlog();

  @override
  void initState() {
    _dashboardDataBloc.add(const OpVisitListBlogEvent.started());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _dashboardDataBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.indigo,
          foregroundColor: Colors.indigo,
          shadowColor: Colors.indigo,
          backgroundColor: Colors.indigo,
          centerTitle: false,
          title: const Text(
            "Appoiment List",
            style: TextStyle(
              color: ConstColor.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddApoiment(
                      opVisitListBlog: _dashboardDataBloc,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.add_circle_outline_sharp,
                color: ConstColor.white,
              ),
            ),
            FxBox.w10,
          ],
        ),
        body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            _dashboardDataBloc.add(const OpVisitListBlogEvent.started());
          },
          child: BlocBuilder<OpVisitListBlog, OpVisitListBlogState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const ListShimmer(),
                success: (opVisitData) {
                  if (opVisitData.isEmpty) {
                    return Center(
                      child: const Text(
                        "No Data Found",
                        style: TextStyle(),
                      ),
                    );
                  }
                  return AnimationLimiter(
                    child: ListView.builder(
                      itemCount: opVisitData.length,
                      itemBuilder: (context, index) {
                        return OpdCard(
                          index: index,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PatientSumaary(
                                    patientName:
                                        opVisitData[index].patientName ?? "",
                                    opIpType: 0,
                                    opdIpdId: opVisitData[index].visitId ?? 0,
                                  ),
                                ));
                          },
                          opdData: opVisitData,
                        );
                      },
                    ),
                  );
                },
                error: (message) {
                  log("opVisitList error: $message");
                  return Center(child: Text(message));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
