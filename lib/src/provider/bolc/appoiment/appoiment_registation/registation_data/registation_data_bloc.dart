import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/op_list/appoiment_registation/patient_registationlist.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registation_data_event.dart';
part 'registation_data_state.dart';
part 'registation_data_bloc.freezed.dart';

class RegistationDataBloc
    extends Bloc<RegistationDataEvent, RegistationDataState> {
  RegistationDataBloc() : super(_Initial()) {
    on<RegistationDataEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              body: {"Keyword": event.searchData},
              procedure: Api.patientRegisterList);
          log("Get Registation Api Response ${response.statusCode}");

          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            log("Get Registation Appoiment Data API Response: $jsonResponse");
            List<GetPatientList> getPatientList =
                GetPatientList.fromMapList(json.decode(response.body));
            emit(_Success(getPatientList.first));
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
        log("Get Registation Appoiment Data api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
