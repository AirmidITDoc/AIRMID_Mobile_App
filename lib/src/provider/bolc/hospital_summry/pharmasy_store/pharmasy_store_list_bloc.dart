import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/hospital_summry/pharmasy_store_list.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pharmasy_store_list_event.dart';
part 'pharmasy_store_list_state.dart';
part 'pharmasy_store_list_bloc.freezed.dart';

class PharmasyStoreListBloc
    extends Bloc<PharmasyStoreListEvent, PharmasyStoreListState> {
  PharmasyStoreListBloc() : super(_Initial()) {
    on<PharmasyStoreListEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              body: {}, procedure: Api.storeList);
          log("HospitalPharmacySummry Api Response ${response.statusCode}");
          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body);
            List<PharmacyStore> departmentName =
                PharmacyStore.fromMapList(responseData);

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
        log("store List Login api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
