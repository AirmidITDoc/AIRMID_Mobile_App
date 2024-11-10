import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/admission_list/appoinment_model.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admision_nursinglist_event.dart';
part 'admision_nursinglist_state.dart';
part 'admision_nursinglist_bloc.freezed.dart';

class AdmiteedPatientDataBloc
    extends Bloc<AdmittedPatientDataEvent, AdmiteedDataState> {
  AdmiteedPatientDataBloc() : super(const _Initial()) {
    on<AdmittedPatientDataEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              procedure: Api.admittedPatient,
              body: {
                'WardID': event.wardId,
                "DoctorId": event.doctorId,
              });
          log("Admiteed Data List Api Response ${response.statusCode}");
          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body);
            List<AdmitListData> admitList = responseData
                .map((e) => AdmitListData.fromMap(e as Map<String, dynamic>))
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
        log("Dashboard list api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
