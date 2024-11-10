import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/hospital_summry/parmasy_dashboard_summry.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hospital_pharmacy_summry_event.dart';
part 'hospital_pharmacy_summry_state.dart';
part 'hospital_pharmacy_summry_bloc.freezed.dart';

class HospitalPharmacySummryBloc
    extends Bloc<HospitalPharmacySummryEvent, HospitalPharmacySummryState> {
  HospitalPharmacySummryBloc() : super(_Initial()) {
    on<HospitalPharmacySummryEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(body: {
            "DateRange": event.dateRange,
            "StoreId": event.StoreId,
          }, procedure: Api.hospitalPharmacySummry);
          log("HospitalPharmacySummry Api Response ${response.statusCode}");
          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body);
            List<HospitalPharmacySummry> departmentName =
                HospitalPharmacySummry.fromMapList(responseData);

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
        log("HospitalPharmacySummry Login api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
