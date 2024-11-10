import 'dart:developer';
import 'dart:ui';

import 'package:airmid/src/constant/color.dart';
import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/provider/bolc/admission_list/admision_nursinglist/admision_nursinglist_bloc.dart';
import 'package:airmid/src/provider/bolc/admission_list/get_patient_doctor_name/get_patient_doctor_name_bloc.dart';
import 'package:airmid/src/provider/bolc/admission_list/get_wardid/get_ward_id_bloc.dart';
import 'package:airmid/src/view/patient_sumaary/patient_sumaary.dart';
import 'package:airmid/src/widget/admission_list/admitted_patient.dart';
import 'package:airmid/src/widget/button.dart';
import 'package:airmid/src/widget/shimmer/list_shimmer.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AdmittedPatient extends StatefulWidget {
  const AdmittedPatient({super.key});

  @override
  State<AdmittedPatient> createState() => _AdmittedPatientState();
}

enum FilterItem { doctorName, wardId }

class _AdmittedPatientState extends State<AdmittedPatient> {
  final AdmiteedPatientDataBloc _admiteedPatientList =
      AdmiteedPatientDataBloc();
  final GetWardIdBloc _getWardIdBloc = GetWardIdBloc();
  final GetPatientDoctorNameBloc _getDoctorNameBloc =
      GetPatientDoctorNameBloc();
  FilterItem? selectedItem;
  final TextEditingController _wardIdController = TextEditingController();
  final TextEditingController _doctorNameController = TextEditingController();
  @override
  void initState() {
    _admiteedPatientList
        .add(const AdmittedPatientDataEvent.started(doctorId: "", wardId: 0));
    _getWardIdBloc.add(GetWardIdEvent.started());
    _getDoctorNameBloc.add(GetPatientDoctorNameEvent.started());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _admiteedPatientList),
        BlocProvider(
            create: (context) => _getWardIdBloc..add(GetWardIdEvent.started())),
        BlocProvider(
            create: (context) =>
                _getDoctorNameBloc..add(GetPatientDoctorNameEvent.started())),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.indigo,
          foregroundColor: Colors.indigo,
          shadowColor: Colors.indigo,
          backgroundColor: Colors.indigo,
          centerTitle: false,
          title: const Text(
            ConstString.admittedPatient,
            style: TextStyle(
              color: ConstColor.white,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: InkWell(
                onTap: () {
                  showModelBottemSheetWidget(context: context);
                },
                child: Icon(Icons.filter_list, color: Colors.white),
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            _admiteedPatientList.add(const AdmittedPatientDataEvent.started(
                doctorId: "", wardId: 0));
          },
          child: BlocBuilder<AdmiteedPatientDataBloc, AdmiteedDataState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListShimmer(),
                ),
                success: (dashboardData) {
                  if (dashboardData.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        _admiteedPatientList.add(
                            const AdmittedPatientDataEvent.started(
                                doctorId: "", wardId: 0));
                      },
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.sizeOf(context).height / 2.5),
                            child: const Center(
                              child: Text(
                                "No Data Found",
                                style: TextStyle(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return AnimationLimiter(
                    child: ListView.builder(
                      itemCount: dashboardData.length,
                      itemBuilder: (context, index) {
                        return AdmittedPatientCard(
                          index: index,
                          admittedData: dashboardData,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PatientSumaary(
                                  patientName:
                                      dashboardData[index].patientName ?? "",
                                  opIpType: 1,
                                  opdIpdId: dashboardData[index].admissionId,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
                error: (message) {
                  log("admitListData Error ");
                  return const Center(child: Text("Somthing went wrong"));
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> showModelBottemSheetWidget({required BuildContext context}) {
    return showModalBottomSheet(
      enableDrag: true,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      isDismissible: true,
      builder: (BuildContext context) {
        _wardIdController.clear();
        _doctorNameController.clear();
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height / 2.7,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => _getWardIdBloc,
                  ),
                  BlocProvider(
                    create: (context) => _getDoctorNameBloc,
                  ),
                ],
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          log("tap");
                          _wardIdController.clear();
                          _doctorNameController.clear();
                          _admiteedPatientList.add(
                              const AdmittedPatientDataEvent.started(
                                  doctorId: "", wardId: 0));
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.clear,
                        ),
                      ),
                    ),
                    BlocBuilder<GetWardIdBloc, GetWardIdState>(
                      builder: (context, state) {
                        return state.when(
                          initial: () => const SizedBox.shrink(),
                          loading: () => Center(
                              child:
                                  const CircularProgressIndicator.adaptive()),
                          success: (getWardId) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Ward",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                FxBox.h10,
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
                                    "Slect Ward",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  value: _wardIdController.text.isEmpty
                                      ? null
                                      : _wardIdController.text,
                                  items: getWardId
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item.wardId.toString(),
                                            child: Text(
                                              item.wardName,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    _wardIdController.text = value.toString();
                                    log("Ward Id:- ${_wardIdController.text}");
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
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ],
                            );
                          },
                          error: (message) => Center(child: Text(message)),
                        );
                      },
                    ),
                    FxBox.h20,
                    BlocBuilder<GetPatientDoctorNameBloc,
                        GetPatientDoctorNameState>(
                      builder: (context, state) {
                        return state.when(
                          initial: () => const SizedBox.shrink(),
                          loading: () => Center(
                              child:
                                  const CircularProgressIndicator.adaptive()),
                          success: (getWardId) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Slect Doctor",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                FxBox.h10,
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
                                    "Select Doctor",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  value: _doctorNameController.text.isEmpty
                                      ? null
                                      : _doctorNameController.text,
                                  items: getWardId
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item.doctorId.toString(),
                                            child: Text(
                                              item.doctorName,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    _doctorNameController.text =
                                        value.toString();
                                    log("Ward Id:- ${_doctorNameController.text}");
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
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ],
                            );
                          },
                          error: (message) => Center(child: Text(message)),
                        );
                      },
                    ),
                    FxBox.h10,
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FxButton(
                        buttonName: "Apply",
                        onTap: () {
                          _admiteedPatientList.add(
                            AdmittedPatientDataEvent.started(
                              doctorId: _doctorNameController.text,
                              wardId: int.parse(
                                  _wardIdController.text.isNotEmpty
                                      ? _wardIdController.text
                                      : "0"),
                            ),
                          );
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
