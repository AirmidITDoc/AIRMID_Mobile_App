import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/op_list/add_appoiment/tariff_master.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tariff_master_event.dart';
part 'tariff_master_state.dart';
part 'tariff_master_bloc.freezed.dart';

class TariffMasterBloc extends Bloc<TariffMasterEvent, TariffMasterState> {
  TariffMasterBloc() : super(_Initial()) {
    on<TariffMasterEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              body: {}, procedure: Api.getTraffict);
          log("PrefixList Api Response ${response.statusCode}");

          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            log("get Traffict API Response: $jsonResponse");
            List<TariffMaster> genderData =
                TariffMaster.fromMapList(json.decode(response.body));
            emit(_Success(genderData));
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
        log("get Traffict api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
