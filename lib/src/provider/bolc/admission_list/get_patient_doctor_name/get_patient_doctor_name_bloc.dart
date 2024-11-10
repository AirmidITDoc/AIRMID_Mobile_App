import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/admission_list/admission_doctor_list.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_patient_doctor_name_event.dart';
part 'get_patient_doctor_name_state.dart';
part 'get_patient_doctor_name_bloc.freezed.dart';

class GetPatientDoctorNameBloc
    extends Bloc<GetPatientDoctorNameEvent, GetPatientDoctorNameState> {
  GetPatientDoctorNameBloc() : super(_Initial()) {
    on<GetPatientDoctorNameEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              procedure: Api.admittedDoctor, body: {});
          log("Admiteed Doctore name List Api Response ${response.statusCode}");
          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body);
            List<GetAdmissionDoctor> admitList = responseData
                .map((e) =>
                    GetAdmissionDoctor.fromMap(e as Map<String, dynamic>))
                .toList();

            emit(_Success(admitList));
          } else if (response.statusCode == 403) {
            emit(_Error(jsonDecode(response.body)['message']));
          } else if (response.statusCode == 500) {
            emit(_Error(jsonDecode(response.body)['message']));
          } else {
            emit(_Error(jsonDecode(response.body)['message']));
          }
        }
      } on SocketException {
        emit(const _Error(ConstString.somthingWentWrong));
      } on PathNotFoundException {
        emit(const _Error(ConstString.somthingWentWrong));
      } on FormatException {
        emit(const _Error(ConstString.serverError));
      } on Exception catch (e) {
        log("Admiteed Doctore name list api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
