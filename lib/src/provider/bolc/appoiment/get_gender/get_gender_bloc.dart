import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/op_list/add_appoiment/gender.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_gender_event.dart';
part 'get_gender_state.dart';
part 'get_gender_bloc.freezed.dart';

class GetGenderBloc extends Bloc<GetGenderEvent, GetGenderState> {
  GetGenderBloc() : super(_Initial()) {
    on<GetGenderEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              body: event.reqBody, procedure: Api.getGender);
          log("PrefixList Api Response ${response.statusCode}");

          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            log("Get Gender API Response: $jsonResponse");
            List<Gender> genderData =
                Gender.fromMapList(json.decode(response.body));
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
        log("PrefixList api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
