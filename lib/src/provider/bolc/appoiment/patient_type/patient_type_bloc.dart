import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/op_list/add_appoiment/patient_type.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_type_event.dart';
part 'patient_type_state.dart';
part 'patient_type_bloc.freezed.dart';

class PatientTypeBloc extends Bloc<PatientTypeEvent, PatientTypeState> {
  PatientTypeBloc() : super(_Initial()) {
    on<PatientTypeEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              body: {}, procedure: Api.patientType);
          log("PrefixList Api Response ${response.statusCode}");

          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            log("Ref Doctor API Response: $jsonResponse");
            List<PatientType> prefixListData =
                PatientType.fromMapList(json.decode(response.body));
            emit(_Success(prefixListData));
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
        log("PatientTypes api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
