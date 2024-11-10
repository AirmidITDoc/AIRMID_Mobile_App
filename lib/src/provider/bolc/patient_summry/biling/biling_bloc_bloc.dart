import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/pation_summry/billing.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'biling_bloc_event.dart';
part 'biling_bloc_state.dart';
part 'biling_bloc_bloc.freezed.dart';

class BilingBlocBloc extends Bloc<BilingBlocEvent, BilingBlocState> {
  BilingBlocBloc() : super(_Initial()) {
    on<BilingBlocEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(body: {
            "OP_IP_Type": event.opIdtype,
            "OPD_IPD_ID": event.opdIpdType
          }, procedure: Api.pationSummryBiling);
          log("Biling Api Response ${response.statusCode}");
          log("Biling Api Response ${response.body}");
          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body);
            List<BilingData> bilingData = BilingData.fromMapList(responseData);

            emit(_Sucess(bilingData));
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
        log("Biling api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
