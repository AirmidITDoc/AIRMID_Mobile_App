import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/op_list/add_appoiment/departmen_name.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_department_name_event.dart';
part 'get_department_name_state.dart';
part 'get_department_name_bloc.freezed.dart';

class GetDepartmentNameBloc
    extends Bloc<GetDepartmentNameEvent, GetDepartmentNameState> {
  GetDepartmentNameBloc() : super(_Initial()) {
    on<GetDepartmentNameEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              body: {}, procedure: Api.getDepartMent);
          log("Api Response ${response.statusCode}");
          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body);
            List<DepartmentName> departmentName =
                DepartmentName.fromMapList(responseData);

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
        log("Login api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
