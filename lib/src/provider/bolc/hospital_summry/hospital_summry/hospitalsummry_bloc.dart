import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/hospital_summry/hospital_summry.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hospitalsummry_event.dart';
part 'hospitalsummry_state.dart';
part 'hospitalsummry_bloc.freezed.dart';

class HospitalsummryBloc
    extends Bloc<HospitalsummryEvent, HospitalsummryState> {
  HospitalsummryBloc() : super(_Initial()) {
    on<HospitalsummryEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              body: {}, procedure: Api.hospitalSummry);
          log("Api Response ${response.statusCode}");
          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body);
            List<HospitalSummryModel> departmentName =
                HospitalSummryModel.fromMapList(responseData);

            emit(_Success(departmentName));
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
        log("Login api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
