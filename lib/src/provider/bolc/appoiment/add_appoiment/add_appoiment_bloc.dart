import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_appoiment_event.dart';
part 'add_appoiment_state.dart';
part 'add_appoiment_bloc.freezed.dart';

class AddAppoimentBloc extends Bloc<AddAppoimentEvent, AddAppoimentState> {
  AddAppoimentBloc() : super(_Initial()) {
    on<AddAppoimentEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.apiCalling(
              body: event.reqBody, apiName: Api.addAppointment);  
          log("PrefixList Api Response ${response.statusCode}");

          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            log("Add Appoiment API Response: $jsonResponse");
            emit(_Success());
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
        log("Add Appoiment api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
