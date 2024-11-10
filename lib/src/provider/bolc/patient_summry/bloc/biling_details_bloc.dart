import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/pation_summry/biling_details.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'biling_details_event.dart';
part 'biling_details_state.dart';
part 'biling_details_bloc.freezed.dart';

class BilingDetailsBloc extends Bloc<BilingDetailsEvent, BilingDetailsState> {
  BilingDetailsBloc() : super(_Initial()) {
    on<BilingDetailsEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(body: {
            "BillNo": event.bilingId,
          }, procedure: Api.bilingDetails);
          log("bilingDetails Api Response ${response.statusCode}");
          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body);
            List<BilingDetailsModel> patientSummryData =
                BilingDetailsModel.fromMapList(responseData);

            emit(_Success(patientSummryData));
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
        log("bilingDetails api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
