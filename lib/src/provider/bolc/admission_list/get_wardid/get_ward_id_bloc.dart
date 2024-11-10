import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/admission_list/get_wardid.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_ward_id_event.dart';
part 'get_ward_id_state.dart';
part 'get_ward_id_bloc.freezed.dart';

class GetWardIdBloc extends Bloc<GetWardIdEvent, GetWardIdState> {
  GetWardIdBloc() : super(_Initial()) {
    on<GetWardIdEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              procedure: Api.wardList, body: {});
          log("Admiteed Data List Api Response ${response.statusCode}");
          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body);
            List<GetWardId> admitList = responseData
                .map((e) => GetWardId.fromMap(e as Map<String, dynamic>))
                .toList();

            emit(_Success(admitList));
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
        log("get Ward id list api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
