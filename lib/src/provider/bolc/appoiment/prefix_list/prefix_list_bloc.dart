import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/op_list/add_appoiment/prefix_list.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'prefix_list_event.dart';
part 'prefix_list_state.dart';
part 'prefix_list_bloc.freezed.dart';

class PrefixListBloc extends Bloc<PrefixListEvent, PrefixListState> {
  PrefixListBloc() : super(_Initial()) {
    on<PrefixListEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              body: {}, procedure: Api.prefixList);
          log("PrefixList Api Response ${response.statusCode}");

          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            log("Ref Doctor API Response: $jsonResponse");
            List<PreFixList> prefixListData =
                PreFixList.fromMapList(json.decode(response.body));
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
        log("PrefixList api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
