import 'dart:developer';

import 'package:airmid/src/constant/loader.dart';
import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/op_list/appoiment_registation/patient_registationlist.dart';
import 'package:airmid/src/provider/bolc/appoiment/add_appoiment/add_appoiment_bloc.dart';
import 'package:airmid/src/provider/bolc/appoiment/appoiment_registation/bloc/add_register_appoinment_bloc.dart';
import 'package:airmid/src/provider/bolc/appoiment/appoiment_registation/registation_data/registation_data_bloc.dart';
import 'package:airmid/src/provider/bolc/appoiment/appoiment_registation/get_appoiment_registation/get_appoiment_registation_bloc.dart';
import 'package:airmid/src/provider/bolc/appoiment/ref_doctor/ref_doctor_bloc.dart';
import 'package:airmid/src/provider/bolc/appoiment/traffic_master/tariff_master_bloc.dart';
import 'package:airmid/src/provider/bolc/appoiment/get_gender/get_gender_bloc.dart';
import 'package:airmid/src/provider/bolc/appoiment/patient_type/patient_type_bloc.dart';
import 'package:airmid/src/provider/bolc/appoiment/prefix_list/prefix_list_bloc.dart';
import 'package:airmid/src/provider/bolc/op_list/appoiment/get_department/get_department_name_bloc.dart';
import 'package:airmid/src/provider/bolc/op_list/appoiment/get_doctor/get_doctor_name_bloc.dart';
import 'package:airmid/src/provider/bolc/op_list/op_visitlist_blog/op_visit_list_blog_bloc.dart';
import 'package:airmid/src/utils/extantion.dart';
import 'package:airmid/src/utils/hive/hive.dart';
import 'package:airmid/src/widget/button.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:airmid/src/widget/text_file.dart';
import 'package:airmid/src/widget/top_snackbar/top_snackbar_path.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddApoiment extends StatefulWidget {
  final OpVisitListBlog opVisitListBlog;
  const AddApoiment({super.key, required this.opVisitListBlog});

  @override
  State<AddApoiment> createState() => _AddApoimentState();
}

class _AddApoimentState extends State<AddApoiment> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _middleName = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _bodController = TextEditingController();
  final TextEditingController _ageYear = TextEditingController();
  final TextEditingController _mobileNo = TextEditingController();
  final TextEditingController _doctorName = TextEditingController();
  final TextEditingController _refDoctorName = TextEditingController();
  final TextEditingController _department = TextEditingController();
  final TextEditingController _prefix = TextEditingController();
  final TextEditingController _patient = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _trafficName = TextEditingController();
  final TextEditingController _dropdownController = TextEditingController();
  final TextEditingController _searchDataController = TextEditingController();
  final TextEditingController _patientSearchController =
      TextEditingController();
  final TextEditingController _prefixSearchController = TextEditingController();
  // final TextEditingController _visitSearchController = TextEditingController();
  final TextEditingController _tariffSearchController = TextEditingController();
  final TextEditingController _departmentSearchController =
      TextEditingController();
  final TextEditingController _refDoctoreSearchController =
      TextEditingController();
  final TextEditingController _doctoreSearchController =
      TextEditingController();

  // update
  final TextEditingController _patientUpdateController =
      TextEditingController();
  final TextEditingController _trafficUpdateController =
      TextEditingController();
  final TextEditingController _departmentNameUpdateController =
      TextEditingController();
  final TextEditingController _doctorNameUpdateController =
      TextEditingController();
  final TextEditingController _refDoctorNameUpdateController =
      TextEditingController();

  final PrefixListBloc _prefixListBloc = PrefixListBloc();
  final GetDepartmentNameBloc _getDepartmentNameBloc = GetDepartmentNameBloc();
  final GetDoctorNameBloc _getDoctorNameBloc = GetDoctorNameBloc();
  final GetGenderBloc _getGender = GetGenderBloc();
  final PatientTypeBloc _patientType = PatientTypeBloc();
  final TariffMasterBloc _tariffMasterBloc = TariffMasterBloc();
  final RefDoctorBloc _refDoctorBloc = RefDoctorBloc();
  final AddAppoimentBloc _addAppoimentBloc = AddAppoimentBloc();
  final GetAppoimentRegistationBloc _getAppoimentRegistationBloc =
      GetAppoimentRegistationBloc();
  final RegistationDataBloc _registationDataBloc = RegistationDataBloc();
  final AddRegisterAppoinmentBloc _addRegisterAppoinmentBloc =
      AddRegisterAppoinmentBloc();
  final List<String> item = [];
  final List<String> id = [];
  List<String> radiobuttonName = [
    'New Registration',
    'Registered',
  ];
  final ValueNotifier<String> _radiobutton =
      ValueNotifier<String>("New Registration");

  int? selected;
  @override
  void initState() {
    _getDepartmentNameBloc.add(GetDepartmentNameEvent.started());
    _prefixListBloc.add(PrefixListEvent.started());
    _patientType.add(PatientTypeEvent.started());
    _tariffMasterBloc.add(TariffMasterEvent.started());
    _refDoctorBloc.add(RefDoctorEvent.started());
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _address.dispose();
    _middleName.dispose();
    _ageYear.dispose();
    _bodController.dispose();
    _lastName.dispose();
    _mobileNo.dispose();
    _doctorName.dispose();
    _department.dispose();
    _refDoctorName.dispose();
    _gender.dispose();
    _prefix.dispose();
    _trafficName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _prefixListBloc),
        BlocProvider(create: (context) => _getDepartmentNameBloc),
        BlocProvider(create: (context) => _getDoctorNameBloc),
        BlocProvider(create: (context) => _getGender),
        BlocProvider(create: (context) => _patientType),
        BlocProvider(create: (context) => _tariffMasterBloc),
        BlocProvider(create: (context) => _refDoctorBloc),
        BlocProvider(create: (context) => _addAppoimentBloc),
        BlocProvider(create: (context) => _getAppoimentRegistationBloc),
        BlocProvider(create: (context) => _registationDataBloc),
        BlocProvider(create: (context) => _addRegisterAppoinmentBloc),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.indigo,
          foregroundColor: Colors.indigo,
          shadowColor: Colors.indigo,
          backgroundColor: Colors.indigo,
          leading: BackButton(color: Colors.white),
          title: const Text(
            ConstString.addPaitent,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ValueListenableBuilder(
                valueListenable: _radiobutton,
                builder: (BuildContext context, String value, Widget? child) =>
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _radioButtonWidget(),
                    FxBox.h20,
                    _radiobutton.value == 'New Registration'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ConstString.personalInformation,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              FxBox.h20,
                              BlocBuilder<PrefixListBloc, PrefixListState>(
                                builder: (context, state) {
                                  return state.when(
                                    initial: () => SizedBox.shrink(),
                                    loading: () => Center(
                                        child: CircularProgressIndicator
                                            .adaptive()),
                                    success: (preFixListData) {
                                      Map<String, String> preefixIdToName = {
                                        for (var store in preFixListData)
                                          store.prefixName:
                                              store.prefixId.toString()
                                      };
                                      return DropdownButtonFormField2<String>(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        hint: const Text(
                                          ConstString.prefix,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        items: preFixListData
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value:
                                                      item.prefixId.toString(),
                                                  child: Text(
                                                    item.prefixName,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return ConstString.prefixError;
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          _prefixSearchController.clear();
                                          _prefix.text = value.toString();
                                          if (_prefix.text.isNotEmpty) {
                                            _getGender.add(
                                              GetGenderEvent.started(
                                                reqBody: {"id": _prefix.text},
                                              ),
                                            );
                                          }
                                          if (value != null) {
                                            String? storeId =
                                                preefixIdToName[value];
                                            if (storeId != null) {
                                              _prefixSearchController.text =
                                                  storeId;
                                              if (_prefixSearchController
                                                  .text.isNotEmpty) {
                                                _getGender.add(
                                                  GetGenderEvent.started(
                                                    reqBody: {
                                                      "id": _prefix.text
                                                    },
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                      );
                                    },
                                    error: (error) {
                                      return Center(child: Text(error));
                                    },
                                  );
                                },
                              ),
                              FxBox.h20,
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: FxTextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: _firstName,
                                      label: const Text(ConstString.firstName),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return ConstString.firstNameErrorMsg;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  FxBox.w10,
                                  Expanded(
                                    child: FxTextFormField(
                                      controller: _middleName,
                                      textInputAction: TextInputAction.next,
                                      label: const Text(ConstString.middleName),
                                      // validator: (value) {
                                      //   if (value == null || value.isEmpty) {
                                      //     return ConstString.middleErrorMsg;
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                  ),
                                ],
                              ),
                              FxBox.h16,
                              FxTextFormField(
                                textInputAction: TextInputAction.next,
                                controller: _lastName,
                                label: const Text(ConstString.lastName),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return ConstString.lastNameErrorMsg;
                                  }
                                  return null;
                                },
                              ),
                              BlocBuilder<GetGenderBloc, GetGenderState>(
                                builder: (context, state) {
                                  return state.when(
                                    initial: () => SizedBox.shrink(),
                                    loading: () => Center(
                                        child: CircularProgressIndicator
                                            .adaptive()),
                                    success: (preFixListData) {
                                      return Column(
                                        children: [
                                          FxBox.h16,
                                          DropdownButtonFormField2<String>(
                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            hint: const Text(
                                              ConstString.gender,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            value: preFixListData.first.genderId
                                                .toString(),
                                            items: preFixListData
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item.genderId
                                                          .toString(),
                                                      child: Text(
                                                        item.genderName,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return ConstString.genderError;
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              _gender.text = value.toString();
                                            },
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black45,
                                              ),
                                              iconSize: 24,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            menuItemStyleData:
                                                const MenuItemStyleData(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    error: (error) {
                                      return Center(child: Text(error));
                                    },
                                  );
                                },
                              ),
                              FxBox.h16,
                              FxTextFormField(
                                controller: _bodController,
                                readOnly: true,
                                label: Text('Birthday'),
                                hintText: 'dd-mm-yyyy',
                                suffixIcon: Icon(Icons.calendar_today),
                                onTap: () {
                                  _selectDate(context);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your birthday';
                                  }
                                  return null;
                                },
                              ),
                              FxBox.h16,
                              FxTextFormField(
                                textInputAction: TextInputAction.next,
                                controller: _address,
                                label: const Text(ConstString.address),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return ConstString.addressErrorMsg;
                                  }
                                  return null;
                                },
                              ),
                              FxBox.h16,
                              FxTextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                controller: _ageYear,
                                label: const Text(ConstString.age),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return ConstString.ageError;
                                  }
                                  return null;
                                },
                              ),
                              FxBox.h16,
                              FxTextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                controller: _mobileNo,
                                maxLength: 10,
                                counterText: "",
                                label: const Text(ConstString.mobileNo),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return ConstString.mobileNoError;
                                  } else if (value.length != 10) {
                                    return ConstString.mobileDigitError;
                                  }
                                  return null;
                                },
                              ),
                              FxBox.h16,
                              Text(
                                ConstString.visitDetails,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              FxBox.h16,
                              BlocBuilder<PatientTypeBloc, PatientTypeState>(
                                builder: (context, state) {
                                  return state.when(
                                    initial: () => SizedBox.shrink(),
                                    loading: () => Center(
                                        child: CircularProgressIndicator
                                            .adaptive()),
                                    success: (patientType) {
                                      _patient.text = patientType
                                          .first.patientTypeId
                                          .toString();
                                      return DropdownButtonFormField2<String>(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        hint: const Text(
                                          ConstString.patient,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: patientType.first.patientTypeId
                                            .toString(),
                                        items: patientType
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.patientTypeId
                                                      .toString(),
                                                  child: Text(
                                                    item.patientType,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return ConstString.patientError;
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          _patient.text = value.toString();
                                          _patientSearchController.clear();
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        dropdownSearchData: DropdownSearchData(
                                          searchController:
                                              _patientSearchController,
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
                                              controller:
                                                  _patientSearchController,
                                              decoration: InputDecoration(
                                                suffixIcon: InkWell(
                                                  onTap: () {
                                                    _patientSearchController
                                                        .clear();
                                                  },
                                                  child: Icon(Icons.clear),
                                                ),
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 8,
                                                ),
                                                hintText: 'Search patient',
                                                hintStyle: const TextStyle(
                                                    fontSize: 12),
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
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                      );
                                    },
                                    error: (error) {
                                      return Center(child: Text(error));
                                    },
                                  );
                                },
                              ),
                              FxBox.h20,
                              BlocBuilder<TariffMasterBloc, TariffMasterState>(
                                builder: (context, state) {
                                  return state.when(
                                    initial: () => SizedBox.shrink(),
                                    loading: () => Center(
                                        child: CircularProgressIndicator
                                            .adaptive()),
                                    success: (tariffMaster) {
                                      _trafficName.text = tariffMaster
                                          .first.tariffId
                                          .toString();
                                      return DropdownButtonFormField2<String>(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        value: tariffMaster.first.tariffId
                                            .toString(),
                                        hint: const Text(
                                          ConstString.trafficName,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        items: tariffMaster
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value:
                                                      item.tariffId.toString(),
                                                  child: Text(
                                                    item.tariffName,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return ConstString.trafficError;
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          _trafficName.text = value.toString();
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        dropdownSearchData: DropdownSearchData(
                                          searchController:
                                              _tariffSearchController,
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
                                              controller:
                                                  _tariffSearchController,
                                              decoration: InputDecoration(
                                                suffixIcon: InkWell(
                                                  onTap: () {
                                                    _tariffSearchController
                                                        .clear();
                                                  },
                                                  child: Icon(Icons.clear),
                                                ),
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 8,
                                                ),
                                                hintText: 'Search traffic',
                                                hintStyle: const TextStyle(
                                                    fontSize: 12),
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
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                      );
                                    },
                                    error: (error) {
                                      return Center(child: Text(error));
                                    },
                                  );
                                },
                              ),
                              FxBox.h20,
                              BlocBuilder<GetDepartmentNameBloc,
                                  GetDepartmentNameState>(
                                builder: (context, state) {
                                  return state.when(
                                    initial: () => SizedBox.shrink(),
                                    loading: () => Center(
                                        child: CircularProgressIndicator
                                            .adaptive()),
                                    success: (departmentList) {
                                      return DropdownButtonFormField2<String>(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        hint: const Text(
                                          ConstString.departmentName,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        items: departmentList
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.departmentid
                                                      .toString(),
                                                  child: Text(
                                                    item.departmentName,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select gender.';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          _department.text = value.toString();
                                          _departmentSearchController.clear();
                                          log("Department value ${_department.text}");
                                          if (_department.text.isNotEmpty) {
                                            _getDoctorNameBloc.add(
                                              GetDoctorNameEvent.started(
                                                {
                                                  "id": _department.text,
                                                },
                                              ),
                                            );
                                          }
                                        },
                                        dropdownSearchData: DropdownSearchData(
                                          searchController:
                                              _departmentSearchController,
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
                                              controller:
                                                  _departmentSearchController,
                                              decoration: InputDecoration(
                                                suffixIcon: InkWell(
                                                  onTap: () {
                                                    _departmentSearchController
                                                        .clear();
                                                  },
                                                  child: Icon(Icons.clear),
                                                ),
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 8,
                                                ),
                                                hintText:
                                                    'Search department name',
                                                hintStyle: const TextStyle(
                                                    fontSize: 12),
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                      );
                                    },
                                    error: (error) {
                                      return Center(child: Text(error));
                                    },
                                  );
                                },
                              ),
                              BlocBuilder<GetDoctorNameBloc,
                                  GetDoctorNameState>(
                                builder: (context, state) {
                                  return state.when(
                                    initial: () => SizedBox.shrink(),
                                    loading: () => Center(
                                        child: CircularProgressIndicator
                                            .adaptive()),
                                    success: (getDoctorName) {
                                      return Column(
                                        children: [
                                          FxBox.h16,
                                          DropdownButtonFormField2<String>(
                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            hint: const Text(
                                              ConstString.doctorName,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            items: getDoctorName
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item.doctorId
                                                          .toString(),
                                                      child: Text(
                                                        item.doctorname,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select doctorName.';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              _department.text =
                                                  value.toString();
                                              log("DoctorName value ${_doctorName.text}");
                                            },
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black45,
                                              ),
                                              iconSize: 24,
                                            ),
                                            dropdownSearchData:
                                                DropdownSearchData(
                                              searchController:
                                                  _doctoreSearchController,
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
                                                  controller:
                                                      _doctoreSearchController,
                                                  decoration: InputDecoration(
                                                    suffixIcon: InkWell(
                                                      onTap: () {
                                                        _doctoreSearchController
                                                            .clear();
                                                      },
                                                      child: Icon(Icons.clear),
                                                    ),
                                                    isDense: true,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                    hintText:
                                                        'Search doctor name',
                                                    hintStyle: const TextStyle(
                                                        fontSize: 12),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              searchMatchFn:
                                                  (item, searchValue) {
                                                return (item.child as Text)
                                                    .data!
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains(searchValue);
                                              },
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            menuItemStyleData:
                                                const MenuItemStyleData(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    error: (error) {
                                      return Center(child: Text(error));
                                    },
                                  );
                                },
                              ),
                              FxBox.h16,
                              BlocBuilder<RefDoctorBloc, RefDoctorState>(
                                builder: (context, state) {
                                  return state.when(
                                    initial: () => SizedBox.shrink(),
                                    loading: () => Center(
                                        child: CircularProgressIndicator
                                            .adaptive()),
                                    success: (refDoctor) {
                                      return DropdownButtonFormField2<String>(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        hint: const Text(
                                          ConstString.rDoctorName,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        items: refDoctor
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value:
                                                      item.doctorId.toString(),
                                                  child: Text(
                                                    item.doctorName,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        // validator: (value) {
                                        //   if (value == null) {
                                        //     return ConstString.rDoctorErrorMsg;
                                        //   }
                                        //   return null;
                                        // },
                                        onChanged: (value) {
                                          _refDoctorName.text =
                                              value.toString();
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        dropdownSearchData: DropdownSearchData(
                                          searchController:
                                              _refDoctoreSearchController,
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
                                              controller:
                                                  _refDoctoreSearchController,
                                              decoration: InputDecoration(
                                                suffixIcon: InkWell(
                                                  onTap: () {
                                                    _refDoctoreSearchController
                                                        .clear();
                                                  },
                                                  child: Icon(Icons.clear),
                                                ),
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 8,
                                                ),
                                                hintText:
                                                    'Search ref doctor name',
                                                hintStyle: const TextStyle(
                                                    fontSize: 12),
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
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                      );
                                    },
                                    error: (error) {
                                      return Center(child: Text(error));
                                    },
                                  );
                                },
                              ),
                              FxBox.h16,
                              BlocListener<AddAppoimentBloc, AddAppoimentState>(
                                listener: (context, state) {
                                  state.when(
                                    initial: () => SizedBox.shrink(),
                                    lpading: () {
                                      Loader.show(context);
                                    },
                                    success: () {
                                      Loader.hide();
                                      widget.opVisitListBlog.add(
                                          const OpVisitListBlogEvent.started());
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.success(
                                          message: "Register SucessFully",
                                        ),
                                      );
                                      Navigator.pop(context);
                                    },
                                    error: (message) {
                                      Loader.hide();
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.error(
                                          message: message.toString(),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: FxButton(
                                    onTap: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        DateTime CurrentDate = DateTime.now();
                                        String currentTime =
                                            DateFormat('h:mm:ss a')
                                                .format(CurrentDate);
                                        String formattedDateOfBirth =
                                            DateFormat('yyyy-MM-dd').format(
                                                DateFormat('dd-MM-yyyy').parse(
                                                    _bodController.text
                                                        .trim()));
                                        Map<String, dynamic> addApoimentBody = {
                                          "registrationSave": {
                                            "regID": 0,
                                            "regDate": DateFormat('MM-dd-yyyy')
                                                .format(CurrentDate)
                                                .toString(),
                                            "regTime": currentTime,
                                            "prefixId":
                                                _prefix.text.trim(), // gender
                                            "firstName": _firstName.text.trim(),
                                            "middleName":
                                                _middleName.text.trim(),
                                            "lastName": _lastName.text.trim(),
                                            "address": _address.text.trim(),
                                            "city": "",
                                            "pinNo": "0",
                                            "dateOfBirth":
                                                formattedDateOfBirth, // date of birth
                                            "age": "0",
                                            "genderID": _gender.text
                                                    .trim()
                                                    .isNotEmpty
                                                ? int.parse(_gender.text.trim())
                                                : 0, // base on prefix
                                            "phoneNo": _mobileNo.text.trim(),
                                            "mobileNo": _mobileNo.text.trim(),
                                            "addedBy": HiveUtils.get(
                                                HiveKeys.userId), // user id
                                            "ageYear": _ageYear.text
                                                .trim(), // age year
                                            "ageMonth": "0",
                                            "ageDay": "0",
                                            "countryId": 1,
                                            "stateId": 1,
                                            "cityId": 21,
                                            "maritalStatusId": 0,
                                            "religionId": 0,
                                            "isCharity": false,
                                            "areaId": 0,
                                            "isSeniorCitizen": false,
                                            "aadharCardNo": "0",
                                            "panCardNo": "0",
                                            "photo": "",
                                          },
                                          "visitSave": {
                                            "visitID": 0,
                                            "regId": 0,
                                            "visitDate":
                                                DateFormat('yyyy-MM-dd')
                                                    .format(CurrentDate),
                                            "visitTime": currentTime,
                                            "unitId": 1,
                                            "patientTypeId":
                                                _patient.text.trim(),
                                            "consultantDocId": 206,
                                            "refDocId":
                                                _refDoctorName.text.trim(),
                                            "tariffId":
                                                _trafficName.text.trim(),
                                            "companyId": 0,
                                            "addedBy": 1,
                                            "updatedBy": 0,
                                            "isCancelled": false,
                                            "isCancelledBy": 0,
                                            "isCancelledDate":
                                                DateFormat('yyyy-MM-dd')
                                                    .format(CurrentDate),
                                            "classId": 1,
                                            "departmentId": _department.text
                                                .trim(), // department id dropdown
                                            "patientOldNew":
                                                1, // while new 1  edit 0
                                            "firstFollowupVisit": 0,
                                            "appPurposeId": 0,
                                            "followupDate":
                                                DateFormat('yyyy-MM-dd')
                                                    .format(CurrentDate),
                                            "crossConsulFlag": 0,
                                            "phoneAppId": 0
                                          },
                                          "tokenNumberWithDoctorWiseSave": {
                                            "patVisitID": 0
                                          }
                                        };

                                        if (kDebugMode) {
                                          log("Add apoiment Body $addApoimentBody");
                                        }
                                        _addAppoimentBloc.add(
                                            AddAppoimentEvent.started(
                                                addApoimentBody));
                                      }
                                    },
                                    buttonName: ConstString.save,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocBuilder<GetAppoimentRegistationBloc,
                                    GetAppoimentRegistationState>(
                                  builder: (context, state) {
                                    return state.when(
                                      initial: () => SizedBox.shrink(),
                                      loading: () => Center(
                                          child: CircularProgressIndicator
                                              .adaptive()),
                                      success: (getPatientList) {
                                        return ValueListenableBuilder(
                                          valueListenable: _dropdownController,
                                          builder: (BuildContext context,
                                                  TextEditingValue value,
                                                  Widget? child) =>
                                              Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton2<String>(
                                                    isExpanded: true,
                                                    hint: Text(
                                                      'Select Item',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Theme.of(context)
                                                            .hintColor,
                                                      ),
                                                    ),
                                                    items: getPatientList
                                                            .isNotEmpty
                                                        ? getPatientList
                                                            .map((item) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: item.regNo,
                                                              child: Text(
                                                                "${item.firstName} | ${item.regNo} | ${item.mobileNo}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            );
                                                          }).toList()
                                                        : [],
                                                    value: _getDropdownValue(
                                                        getPatientList:
                                                            getPatientList),
                                                    onChanged: (value) {
                                                      _dropdownController.text =
                                                          value ?? "";
                                                      _registationDataBloc.add(
                                                        RegistationDataEvent
                                                            .started(value!),
                                                      );
                                                    },
                                                    buttonStyleData:
                                                        const ButtonStyleData(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16),
                                                      height: 40,
                                                    ),
                                                    dropdownStyleData:
                                                        const DropdownStyleData(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                      ),
                                                      maxHeight: 200,
                                                    ),
                                                    dropdownSearchData:
                                                        DropdownSearchData(
                                                      searchController:
                                                          _searchDataController,
                                                      searchInnerWidgetHeight:
                                                          50,
                                                      searchInnerWidget:
                                                          Container(
                                                        height: 50,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 8,
                                                          bottom: 4,
                                                          right: 8,
                                                          left: 8,
                                                        ),
                                                        child: TextFormField(
                                                          expands: true,
                                                          maxLines: null,
                                                          controller:
                                                              _searchDataController,
                                                          decoration:
                                                              InputDecoration(
                                                            suffixIcon: InkWell(
                                                              onTap: () {
                                                                _searchDataController
                                                                    .clear();
                                                              },
                                                              child: Icon(
                                                                  Icons.clear),
                                                            ),
                                                            isDense: true,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 10,
                                                              vertical: 8,
                                                            ),
                                                            hintText:
                                                                'Search patient',
                                                            hintStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      searchMatchFn:
                                                          (item, searchValue) {
                                                        final patient = getPatientList
                                                            .firstWhere(
                                                                (patient) =>
                                                                    patient
                                                                        .regNo ==
                                                                    item.value);
                                                        return patient.firstName
                                                                .toLowerCase()
                                                                .contains(
                                                                    searchValue
                                                                        .toLowerCase()) ||
                                                            patient.lastName
                                                                .toLowerCase()
                                                                .contains(
                                                                    searchValue
                                                                        .toLowerCase()) ||
                                                            patient.regNo
                                                                .toLowerCase()
                                                                .contains(
                                                                    searchValue
                                                                        .toLowerCase()) ||
                                                            patient.mobileNo
                                                                .toLowerCase()
                                                                .contains(
                                                                    searchValue
                                                                        .toLowerCase());
                                                      },
                                                    ),
                                                    onMenuStateChange:
                                                        (isOpen) {
                                                      if (!isOpen) {
                                                        _searchDataController
                                                            .clear();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              BlocBuilder<RegistationDataBloc,
                                                  RegistationDataState>(
                                                builder: (context, state) {
                                                  return state.when(
                                                    initial: () =>
                                                        SizedBox.shrink(),
                                                    loading: () => Center(
                                                        child:
                                                            CircularProgressIndicator
                                                                .adaptive()),
                                                    success: (getPatientList) {
                                                      if (_dropdownController
                                                          .text.isEmpty) {
                                                        return SizedBox
                                                            .shrink();
                                                      } else {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FxBox.h20,
                                                            Divider(),
                                                            buildSectionHeader(
                                                                'Personal Details'),
                                                            buildInfoRow(
                                                                'UHID',
                                                                getPatientList
                                                                    .regNoWithPrefix),
                                                            buildInfoRow('Name',
                                                                '${getPatientList.prefixName} ${getPatientList.firstName} ${getPatientList.middleName} ${getPatientList.lastName}'),
                                                            buildInfoRow(
                                                                'Address',
                                                                getPatientList
                                                                    .address),
                                                            buildInfoRow(
                                                                'City',
                                                                getPatientList
                                                                    .city),
                                                            buildInfoRow(
                                                                'Pin No',
                                                                getPatientList
                                                                    .pinNo),
                                                            buildInfoRow(
                                                                'Date of Birth',
                                                                getPatientList
                                                                    .dateofBirth
                                                                    .toFormattedString()),
                                                            buildInfoRow(
                                                                'Age',
                                                                "".formatAge(
                                                                    getPatientList
                                                                        .ageYear,
                                                                    getPatientList
                                                                        .ageMonth,
                                                                    getPatientList
                                                                        .ageDay)),
                                                            buildInfoRow(
                                                                'Gender',
                                                                getPatientList
                                                                    .genderName),
                                                            FxBox.h10,
                                                            Divider(),
                                                            Theme(
                                                              data: Theme.of(
                                                                      context)
                                                                  .copyWith(
                                                                dividerColor: Colors
                                                                    .transparent,
                                                              ),
                                                              child:
                                                                  ExpansionTile(
                                                                tilePadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                title: buildSectionHeader(
                                                                    'Contact Details'),
                                                                children: <Widget>[
                                                                  buildInfoRow(
                                                                      'Phone No',
                                                                      getPatientList
                                                                          .phoneNo),
                                                                  buildInfoRow(
                                                                      'Mobile No',
                                                                      getPatientList
                                                                          .mobileNo),
                                                                  buildInfoRow(
                                                                      'Aadhar Card No',
                                                                      getPatientList
                                                                          .aadharCardNo),
                                                                ],
                                                              ),
                                                            ),
                                                            FxBox.h10,
                                                            Divider(),
                                                            FxBox.h10,
                                                            buildSectionHeader(
                                                                ConstString
                                                                    .visitDetails),
                                                            FxBox.h16,
                                                            BlocBuilder<
                                                                PatientTypeBloc,
                                                                PatientTypeState>(
                                                              builder: (context,
                                                                  state) {
                                                                return state
                                                                    .when(
                                                                  initial: () =>
                                                                      SizedBox
                                                                          .shrink(),
                                                                  loading: () =>
                                                                      Center(
                                                                          child:
                                                                              CircularProgressIndicator.adaptive()),
                                                                  success:
                                                                      (patientType) {
                                                                    _patientUpdateController
                                                                            .text =
                                                                        patientType
                                                                            .first
                                                                            .patientTypeId
                                                                            .toString();
                                                                    return DropdownButtonFormField2<
                                                                        String>(
                                                                      isExpanded:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        contentPadding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                16),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                        ),
                                                                      ),
                                                                      hint:
                                                                          const Text(
                                                                        ConstString
                                                                            .patient,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14),
                                                                      ),
                                                                      value: _patientUpdateController
                                                                              .text
                                                                              .isEmpty
                                                                          ? patientType
                                                                              .first
                                                                              .patientTypeId
                                                                              .toString()
                                                                          : _patientUpdateController
                                                                              .text,
                                                                      items: patientType
                                                                          .map((item) => DropdownMenuItem<String>(
                                                                                value: item.patientTypeId.toString(),
                                                                                child: Text(
                                                                                  item.patientType,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                              ))
                                                                          .toList(),
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                            null) {
                                                                          return ConstString
                                                                              .patientError;
                                                                        }
                                                                        return null;
                                                                      },
                                                                      onChanged:
                                                                          (value) {
                                                                        _patientUpdateController.text =
                                                                            value.toString();
                                                                        _patientSearchController
                                                                            .clear();
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      buttonStyleData:
                                                                          const ButtonStyleData(
                                                                        padding:
                                                                            EdgeInsets.only(right: 8),
                                                                      ),
                                                                      iconStyleData:
                                                                          const IconStyleData(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_drop_down,
                                                                          color:
                                                                              Colors.black45,
                                                                        ),
                                                                        iconSize:
                                                                            24,
                                                                      ),
                                                                      dropdownStyleData:
                                                                          DropdownStyleData(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                        ),
                                                                      ),
                                                                      dropdownSearchData:
                                                                          DropdownSearchData(
                                                                        searchController:
                                                                            _patientSearchController,
                                                                        searchInnerWidgetHeight:
                                                                            50,
                                                                        searchInnerWidget:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            top:
                                                                                8,
                                                                            bottom:
                                                                                4,
                                                                            right:
                                                                                8,
                                                                            left:
                                                                                8,
                                                                          ),
                                                                          child:
                                                                              TextFormField(
                                                                            expands:
                                                                                true,
                                                                            maxLines:
                                                                                null,
                                                                            controller:
                                                                                _patientSearchController,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              suffixIcon: InkWell(
                                                                                onTap: () {
                                                                                  _patientSearchController.clear();
                                                                                },
                                                                                child: Icon(Icons.clear),
                                                                              ),
                                                                              isDense: true,
                                                                              contentPadding: const EdgeInsets.symmetric(
                                                                                horizontal: 10,
                                                                                vertical: 8,
                                                                              ),
                                                                              hintText: 'Search patient',
                                                                              hintStyle: const TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        searchMatchFn:
                                                                            (item,
                                                                                searchValue) {
                                                                          return (item.child as Text)
                                                                              .data!
                                                                              .toString()
                                                                              .toLowerCase()
                                                                              .contains(searchValue);
                                                                        },
                                                                      ),
                                                                      menuItemStyleData:
                                                                          const MenuItemStyleData(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 16),
                                                                      ),
                                                                    );
                                                                  },
                                                                  error:
                                                                      (error) {
                                                                    return Center(
                                                                        child: Text(
                                                                            error));
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                            FxBox.h20,
                                                            BlocBuilder<
                                                                TariffMasterBloc,
                                                                TariffMasterState>(
                                                              builder: (context,
                                                                  state) {
                                                                return state
                                                                    .when(
                                                                  initial: () =>
                                                                      SizedBox
                                                                          .shrink(),
                                                                  loading: () =>
                                                                      Center(
                                                                          child:
                                                                              CircularProgressIndicator.adaptive()),
                                                                  success:
                                                                      (tariffMaster) {
                                                                    _trafficUpdateController
                                                                            .text =
                                                                        tariffMaster
                                                                            .first
                                                                            .tariffId
                                                                            .toString();
                                                                    return DropdownButtonFormField2<
                                                                        String>(
                                                                      isExpanded:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        contentPadding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                16),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                        ),
                                                                      ),
                                                                      value: _trafficUpdateController
                                                                              .text
                                                                              .isEmpty
                                                                          ? tariffMaster
                                                                              .first
                                                                              .tariffId
                                                                              .toString()
                                                                          : _trafficUpdateController
                                                                              .text,
                                                                      hint:
                                                                          const Text(
                                                                        ConstString
                                                                            .trafficName,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14),
                                                                      ),
                                                                      items: tariffMaster
                                                                          .map((item) => DropdownMenuItem<String>(
                                                                                value: item.tariffId.toString(),
                                                                                child: Text(
                                                                                  item.tariffName,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                              ))
                                                                          .toList(),
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                            null) {
                                                                          return ConstString
                                                                              .trafficError;
                                                                        }
                                                                        return null;
                                                                      },
                                                                      onChanged:
                                                                          (value) {
                                                                        log("Update Of Traffice ${value}");
                                                                        _trafficUpdateController.text =
                                                                            value.toString();
                                                                        log("Update Of Traffic ${_trafficUpdateController.text}");
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      buttonStyleData:
                                                                          const ButtonStyleData(
                                                                        padding:
                                                                            EdgeInsets.only(right: 8),
                                                                      ),
                                                                      iconStyleData:
                                                                          const IconStyleData(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_drop_down,
                                                                          color:
                                                                              Colors.black45,
                                                                        ),
                                                                        iconSize:
                                                                            24,
                                                                      ),
                                                                      dropdownStyleData:
                                                                          DropdownStyleData(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                        ),
                                                                      ),
                                                                      dropdownSearchData:
                                                                          DropdownSearchData(
                                                                        searchController:
                                                                            _tariffSearchController,
                                                                        searchInnerWidgetHeight:
                                                                            50,
                                                                        searchInnerWidget:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            top:
                                                                                8,
                                                                            bottom:
                                                                                4,
                                                                            right:
                                                                                8,
                                                                            left:
                                                                                8,
                                                                          ),
                                                                          child:
                                                                              TextFormField(
                                                                            expands:
                                                                                true,
                                                                            maxLines:
                                                                                null,
                                                                            controller:
                                                                                _tariffSearchController,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              suffixIcon: InkWell(
                                                                                onTap: () {
                                                                                  _tariffSearchController.clear();
                                                                                },
                                                                                child: Icon(Icons.clear),
                                                                              ),
                                                                              isDense: true,
                                                                              contentPadding: const EdgeInsets.symmetric(
                                                                                horizontal: 10,
                                                                                vertical: 8,
                                                                              ),
                                                                              hintText: 'Search traffic',
                                                                              hintStyle: const TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        searchMatchFn:
                                                                            (item,
                                                                                searchValue) {
                                                                          return (item.child as Text)
                                                                              .data!
                                                                              .toString()
                                                                              .toLowerCase()
                                                                              .contains(searchValue);
                                                                        },
                                                                      ),
                                                                      menuItemStyleData:
                                                                          const MenuItemStyleData(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 16),
                                                                      ),
                                                                    );
                                                                  },
                                                                  error:
                                                                      (error) {
                                                                    return Center(
                                                                        child: Text(
                                                                            error));
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                            FxBox.h20,
                                                            BlocBuilder<
                                                                GetDepartmentNameBloc,
                                                                GetDepartmentNameState>(
                                                              builder: (context,
                                                                  state) {
                                                                return state
                                                                    .when(
                                                                  initial: () =>
                                                                      SizedBox
                                                                          .shrink(),
                                                                  loading: () =>
                                                                      Center(
                                                                          child:
                                                                              CircularProgressIndicator.adaptive()),
                                                                  success:
                                                                      (departmentList) {
                                                                    return DropdownButtonFormField2<
                                                                        String>(
                                                                      isExpanded:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        contentPadding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                16),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                        ),
                                                                      ),
                                                                      hint:
                                                                          const Text(
                                                                        ConstString
                                                                            .departmentName,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14),
                                                                      ),
                                                                      items: departmentList
                                                                          .map((item) => DropdownMenuItem<String>(
                                                                                value: item.departmentid.toString(),
                                                                                child: Text(
                                                                                  item.departmentName,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                              ))
                                                                          .toList(),
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                            null) {
                                                                          return 'Please select gender.';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      onChanged:
                                                                          (value) {
                                                                        _departmentNameUpdateController.text =
                                                                            value.toString();
                                                                        _departmentSearchController
                                                                            .clear();
                                                                        log("Department value ${_departmentNameUpdateController.text}");
                                                                        if (_departmentNameUpdateController
                                                                            .text
                                                                            .isNotEmpty) {
                                                                          _getDoctorNameBloc
                                                                              .add(
                                                                            GetDoctorNameEvent.started(
                                                                              {
                                                                                "id": _departmentNameUpdateController.text,
                                                                              },
                                                                            ),
                                                                          );
                                                                        }
                                                                      },
                                                                      dropdownSearchData:
                                                                          DropdownSearchData(
                                                                        searchController:
                                                                            _departmentSearchController,
                                                                        searchInnerWidgetHeight:
                                                                            50,
                                                                        searchInnerWidget:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            top:
                                                                                8,
                                                                            bottom:
                                                                                4,
                                                                            right:
                                                                                8,
                                                                            left:
                                                                                8,
                                                                          ),
                                                                          child:
                                                                              TextFormField(
                                                                            expands:
                                                                                true,
                                                                            maxLines:
                                                                                null,
                                                                            controller:
                                                                                _departmentSearchController,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              suffixIcon: InkWell(
                                                                                onTap: () {
                                                                                  _departmentSearchController.clear();
                                                                                },
                                                                                child: Icon(Icons.clear),
                                                                              ),
                                                                              isDense: true,
                                                                              contentPadding: const EdgeInsets.symmetric(
                                                                                horizontal: 10,
                                                                                vertical: 8,
                                                                              ),
                                                                              hintText: 'Search department name',
                                                                              hintStyle: const TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        searchMatchFn:
                                                                            (item,
                                                                                searchValue) {
                                                                          return (item.child as Text)
                                                                              .data!
                                                                              .toString()
                                                                              .toLowerCase()
                                                                              .contains(searchValue);
                                                                        },
                                                                      ),
                                                                      buttonStyleData:
                                                                          const ButtonStyleData(
                                                                        padding:
                                                                            EdgeInsets.only(right: 8),
                                                                      ),
                                                                      iconStyleData:
                                                                          const IconStyleData(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_drop_down,
                                                                          color:
                                                                              Colors.black45,
                                                                        ),
                                                                        iconSize:
                                                                            24,
                                                                      ),
                                                                      dropdownStyleData:
                                                                          DropdownStyleData(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                        ),
                                                                      ),
                                                                      menuItemStyleData:
                                                                          const MenuItemStyleData(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 16),
                                                                      ),
                                                                    );
                                                                  },
                                                                  error:
                                                                      (error) {
                                                                    return Center(
                                                                        child: Text(
                                                                            error));
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                            BlocBuilder<
                                                                GetDoctorNameBloc,
                                                                GetDoctorNameState>(
                                                              builder: (context,
                                                                  state) {
                                                                return state
                                                                    .when(
                                                                  initial: () =>
                                                                      SizedBox
                                                                          .shrink(),
                                                                  loading: () =>
                                                                      Center(
                                                                          child:
                                                                              CircularProgressIndicator.adaptive()),
                                                                  success:
                                                                      (getDoctorName) {
                                                                    return Column(
                                                                      children: [
                                                                        FxBox
                                                                            .h16,
                                                                        DropdownButtonFormField2<
                                                                            String>(
                                                                          isExpanded:
                                                                              true,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            contentPadding:
                                                                                const EdgeInsets.symmetric(vertical: 16),
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                          ),
                                                                          hint:
                                                                              const Text(
                                                                            ConstString.doctorName,
                                                                            style:
                                                                                TextStyle(fontSize: 14),
                                                                          ),
                                                                          items: getDoctorName
                                                                              .map((item) => DropdownMenuItem<String>(
                                                                                    value: item.doctorId.toString(),
                                                                                    child: Text(
                                                                                      item.doctorname,
                                                                                      style: const TextStyle(
                                                                                        fontSize: 14,
                                                                                      ),
                                                                                    ),
                                                                                  ))
                                                                              .toList(),
                                                                          validator:
                                                                              (value) {
                                                                            if (value ==
                                                                                null) {
                                                                              return 'Please select doctorName.';
                                                                            }
                                                                            return null;
                                                                          },
                                                                          onChanged:
                                                                              (value) {
                                                                            _doctorNameUpdateController.text =
                                                                                value.toString();
                                                                            log("DoctorName value ${_doctorNameUpdateController.text}");
                                                                          },
                                                                          buttonStyleData:
                                                                              const ButtonStyleData(
                                                                            padding:
                                                                                EdgeInsets.only(right: 8),
                                                                          ),
                                                                          iconStyleData:
                                                                              const IconStyleData(
                                                                            icon:
                                                                                Icon(
                                                                              Icons.arrow_drop_down,
                                                                              color: Colors.black45,
                                                                            ),
                                                                            iconSize:
                                                                                24,
                                                                          ),
                                                                          dropdownSearchData:
                                                                              DropdownSearchData(
                                                                            searchController:
                                                                                _doctoreSearchController,
                                                                            searchInnerWidgetHeight:
                                                                                50,
                                                                            searchInnerWidget:
                                                                                Container(
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
                                                                                controller: _doctoreSearchController,
                                                                                decoration: InputDecoration(
                                                                                  suffixIcon: InkWell(
                                                                                    onTap: () {
                                                                                      _doctoreSearchController.clear();
                                                                                    },
                                                                                    child: Icon(Icons.clear),
                                                                                  ),
                                                                                  isDense: true,
                                                                                  contentPadding: const EdgeInsets.symmetric(
                                                                                    horizontal: 10,
                                                                                    vertical: 8,
                                                                                  ),
                                                                                  hintText: 'Search doctor name',
                                                                                  hintStyle: const TextStyle(fontSize: 12),
                                                                                  border: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            searchMatchFn:
                                                                                (item, searchValue) {
                                                                              return (item.child as Text).data!.toString().toLowerCase().contains(searchValue);
                                                                            },
                                                                          ),
                                                                          dropdownStyleData:
                                                                              DropdownStyleData(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(15),
                                                                            ),
                                                                          ),
                                                                          menuItemStyleData:
                                                                              const MenuItemStyleData(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 16),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                  error:
                                                                      (error) {
                                                                    return Center(
                                                                        child: Text(
                                                                            error));
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                            FxBox.h16,
                                                            BlocBuilder<
                                                                RefDoctorBloc,
                                                                RefDoctorState>(
                                                              builder: (context,
                                                                  state) {
                                                                return state
                                                                    .when(
                                                                  initial: () =>
                                                                      SizedBox
                                                                          .shrink(),
                                                                  loading: () =>
                                                                      Center(
                                                                          child:
                                                                              CircularProgressIndicator.adaptive()),
                                                                  success:
                                                                      (refDoctor) {
                                                                    return DropdownButtonFormField2<
                                                                        String>(
                                                                      isExpanded:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        contentPadding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                16),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                        ),
                                                                      ),
                                                                      hint:
                                                                          const Text(
                                                                        ConstString
                                                                            .rDoctorName,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14),
                                                                      ),
                                                                      items: refDoctor
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
                                                                      // validator: (value) {
                                                                      //   if (value == null) {
                                                                      //     return ConstString.rDoctorErrorMsg;
                                                                      //   }
                                                                      //   return null;
                                                                      // },
                                                                      onChanged:
                                                                          (value) {
                                                                        _refDoctorNameUpdateController.text =
                                                                            value.toString();
                                                                      },
                                                                      buttonStyleData:
                                                                          const ButtonStyleData(
                                                                        padding:
                                                                            EdgeInsets.only(right: 8),
                                                                      ),
                                                                      iconStyleData:
                                                                          const IconStyleData(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_drop_down,
                                                                          color:
                                                                              Colors.black45,
                                                                        ),
                                                                        iconSize:
                                                                            24,
                                                                      ),
                                                                      dropdownStyleData:
                                                                          DropdownStyleData(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                        ),
                                                                      ),
                                                                      dropdownSearchData:
                                                                          DropdownSearchData(
                                                                        searchController:
                                                                            _refDoctoreSearchController,
                                                                        searchInnerWidgetHeight:
                                                                            50,
                                                                        searchInnerWidget:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            top:
                                                                                8,
                                                                            bottom:
                                                                                4,
                                                                            right:
                                                                                8,
                                                                            left:
                                                                                8,
                                                                          ),
                                                                          child:
                                                                              TextFormField(
                                                                            expands:
                                                                                true,
                                                                            maxLines:
                                                                                null,
                                                                            controller:
                                                                                _refDoctoreSearchController,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              suffixIcon: InkWell(
                                                                                onTap: () {
                                                                                  _refDoctoreSearchController.clear();
                                                                                },
                                                                                child: Icon(Icons.clear),
                                                                              ),
                                                                              isDense: true,
                                                                              contentPadding: const EdgeInsets.symmetric(
                                                                                horizontal: 10,
                                                                                vertical: 8,
                                                                              ),
                                                                              hintText: 'Search ref doctor name',
                                                                              hintStyle: const TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        searchMatchFn:
                                                                            (item,
                                                                                searchValue) {
                                                                          return (item.child as Text)
                                                                              .data!
                                                                              .toString()
                                                                              .toLowerCase()
                                                                              .contains(searchValue);
                                                                        },
                                                                      ),
                                                                      menuItemStyleData:
                                                                          const MenuItemStyleData(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 16),
                                                                      ),
                                                                    );
                                                                  },
                                                                  error:
                                                                      (error) {
                                                                    return Center(
                                                                        child: Text(
                                                                            error));
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                            FxBox.h20,
                                                            BlocListener<
                                                                AddRegisterAppoinmentBloc,
                                                                AddRegisterAppoinmentState>(
                                                              listener:
                                                                  (context,
                                                                      state) {
                                                                state.when(
                                                                    initial: () =>
                                                                        SizedBox
                                                                            .shrink(),
                                                                    loading:
                                                                        () {
                                                                      Loader.show(
                                                                          context);
                                                                    },
                                                                    success:
                                                                        () {
                                                                      Loader
                                                                          .hide();
                                                                      widget
                                                                          .opVisitListBlog
                                                                          .add(const OpVisitListBlogEvent
                                                                              .started());
                                                                      showTopSnackBar(
                                                                        Overlay.of(
                                                                            context),
                                                                        const CustomSnackBar
                                                                            .success(
                                                                          message:
                                                                              "Register SucessFully",
                                                                        ),
                                                                      );
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    error:
                                                                        (error) {
                                                                      Loader
                                                                          .hide();
                                                                      showTopSnackBar(
                                                                        Overlay.of(
                                                                            context),
                                                                        CustomSnackBar
                                                                            .error(
                                                                          message:
                                                                              error,
                                                                        ),
                                                                      );
                                                                    });
                                                              },
                                                              child: FxButton(
                                                                onTap: () {
                                                                  if (_formKey
                                                                          .currentState
                                                                          ?.validate() ??
                                                                      false) {
                                                                    String
                                                                        formattedDateOfBirth =
                                                                        DateFormat('MM-dd-yyyy').format(DateTime.parse(getPatientList
                                                                            .dateofBirth
                                                                            .toString()));
                                                                    log("Formatted Date of Birth ${formattedDateOfBirth}");
                                                                    DateTime
                                                                        CurrentDate =
                                                                        DateTime
                                                                            .now();
                                                                    String
                                                                        currentTime =
                                                                        DateFormat('h:mm:ss a')
                                                                            .format(CurrentDate);
                                                                    Map<String,
                                                                            dynamic>
                                                                        registrationApoimentBody =
                                                                        {
                                                                      "registrationUpdate":
                                                                          {
                                                                        "regID":
                                                                            getPatientList.regId,
                                                                        "regDate": getPatientList
                                                                            .regDate
                                                                            .toString(),
                                                                        "regTime": getPatientList
                                                                            .regTime
                                                                            .toString(),
                                                                        "prefixId":
                                                                            getPatientList.prefixId,
                                                                        "firstName":
                                                                            getPatientList.firstName,
                                                                        "middleName":
                                                                            getPatientList.middleName,
                                                                        "lastName":
                                                                            getPatientList.lastName,
                                                                        "address":
                                                                            getPatientList.address,
                                                                        "City":
                                                                            getPatientList.city,
                                                                        "pinNo":
                                                                            getPatientList.pinNo,
                                                                        "dateOfBirth":
                                                                            formattedDateOfBirth,
                                                                        "age": getPatientList
                                                                            .age,
                                                                        "genderID":
                                                                            getPatientList.genderId,
                                                                        "phoneNo":
                                                                            getPatientList.phoneNo,
                                                                        "mobileNo":
                                                                            getPatientList.mobileNo,
                                                                        "addedBy":
                                                                            HiveUtils.get(HiveKeys.userId),
                                                                        "ageYear":
                                                                            getPatientList.ageYear,
                                                                        "ageMonth":
                                                                            getPatientList.ageMonth,
                                                                        "ageDay":
                                                                            getPatientList.ageDay,
                                                                        "countryId":
                                                                            getPatientList.countryId,
                                                                        "stateId":
                                                                            getPatientList.stateId,
                                                                        "cityId":
                                                                            getPatientList.cityId,
                                                                        "maritalStatusId":
                                                                            getPatientList.maritalStatusId,
                                                                        "isCharity":
                                                                            getPatientList.isCharity,
                                                                        "religionId":
                                                                            getPatientList.religionId,
                                                                        "areaId":
                                                                            getPatientList.areaId,
                                                                        "Aadharcardno":
                                                                            getPatientList.aadharCardNo,
                                                                        "Pancardno":
                                                                            "",
                                                                        "Photo":
                                                                            ""
                                                                      },
                                                                      "visitSave":
                                                                          {
                                                                        "VisitId":
                                                                            0,
                                                                        "RegID":
                                                                            getPatientList.regId,
                                                                        "VisitDate": DateFormat('MM-dd-yyyy')
                                                                            .format(CurrentDate)
                                                                            .toString(),
                                                                        "VisitTime":
                                                                            currentTime,
                                                                        "UnitId":
                                                                            1,
                                                                        "PatientTypeId": _patientUpdateController
                                                                            .text
                                                                            .trim(),
                                                                        "ConsultantDocId": _doctorNameUpdateController
                                                                            .text
                                                                            .trim(),
                                                                        "RefDocId": _refDoctorNameUpdateController
                                                                            .text
                                                                            .trim(),
                                                                        "TariffId": _trafficUpdateController
                                                                            .text
                                                                            .trim(),
                                                                        "CompanyId":
                                                                            0,
                                                                        "AddedBy":
                                                                            HiveUtils.get(HiveKeys.userId),
                                                                        "updatedBy":
                                                                            HiveUtils.get(HiveKeys.userId),
                                                                        "IsCancelled":
                                                                            0,
                                                                        "IsCancelledBy":
                                                                            0,
                                                                        "IsCancelledDate": DateFormat('MM-dd-yyyy')
                                                                            .format(CurrentDate)
                                                                            .toString(),
                                                                        "ClassId":
                                                                            1,
                                                                        "DepartmentId": _departmentNameUpdateController
                                                                            .text
                                                                            .trim(),
                                                                        "PatientOldNew":
                                                                            2,
                                                                        "FirstFollowupVisit":
                                                                            0,
                                                                        "appPurposeId":
                                                                            0,
                                                                        "FollowupDate": DateFormat('MM-dd-yyyy')
                                                                            .format(CurrentDate)
                                                                            .toString(),
                                                                        "crossConsulFlag":
                                                                            0,
                                                                        "phoneAppId":
                                                                            0
                                                                      },
                                                                      "tokenNumberWithDoctorWiseSave":
                                                                          {
                                                                        "patVisitID":
                                                                            0
                                                                      }
                                                                    };
                                                                    if (kDebugMode) {
                                                                      log("Add Registation apoiment Body ${registrationApoimentBody}");
                                                                    }
                                                                    _addRegisterAppoinmentBloc.add(
                                                                        AddRegisterAppoinmentEvent.started(
                                                                            registrationApoimentBody));
                                                                  }
                                                                },
                                                                buttonName:
                                                                    ConstString
                                                                        .save,
                                                              ),
                                                            ),
                                                            FxBox.h20,
                                                          ],
                                                        );
                                                      }
                                                    },
                                                    error: (message) => Center(
                                                        child: Text(message)),
                                                  );
                                                },
                                              ),
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
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _bodController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  Widget _radioButtonWidget() {
    return ValueListenableBuilder(
      valueListenable: _radiobutton,
      builder: (BuildContext context, value, Widget? child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            2,
            (index) {
              return Flexible(
                child: Column(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                      ),
                      child: RadioListTile(
                        hoverColor: Colors.transparent,
                        tileColor: Colors.transparent,
                        overlayColor:
                            const WidgetStatePropertyAll(Colors.transparent),
                        selectedTileColor: Colors.transparent,
                        fillColor: const WidgetStatePropertyAll(Colors.black),
                        contentPadding: EdgeInsets.zero,
                        title: Text(radiobuttonName[index]),
                        value: radiobuttonName[index],
                        groupValue: _radiobutton.value,
                        onChanged: (value) {
                          _radiobutton.value = value!;
                          if (_radiobutton.value != 'New Registration') {
                            _dropdownController.clear();
                            _getAppoimentRegistationBloc
                                .add(GetAppoimentRegistationEvent.started(""));
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  String? _getDropdownValue({required List<GetPatientList> getPatientList}) {
    if (getPatientList.isEmpty) {
      return null;
    }
    if (_dropdownController.text.isEmpty) {
      return null;
    }
    return getPatientList
            .map((item) => item.firstName)
            .contains(_dropdownController.text)
        ? _dropdownController.text
        : null;
  }
}

Widget buildSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
    child: Text(
      title,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
    ),
  );
}

Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
  );
}
