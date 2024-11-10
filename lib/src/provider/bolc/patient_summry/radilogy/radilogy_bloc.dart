import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/pation_summry/radailogy.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'radilogy_event.dart';
part 'radilogy_state.dart';
part 'radilogy_bloc.freezed.dart';

class RadilogyBloc extends Bloc<RadilogyEvent, RadilogyState> {
  RadilogyBloc() : super(_Initial()) {
    on<RadilogyEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(body: {
            "OP_IP_Type": event.opIdtype,
            "OPD_IPD_ID": event.opdIpdType
          }, procedure: Api.pationSummryRadilogy);
          log("Radiology Api Response ${response.statusCode}");
          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body);
            List<RadiologyList> radiologySummryData =
                RadiologyList.fromMapList(responseData);

            emit(_Success(radiologySummryData));
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
        log("Radiology api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
