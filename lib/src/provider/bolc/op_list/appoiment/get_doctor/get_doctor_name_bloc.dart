import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/op_list/add_appoiment/get_doctorname.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_doctor_name_event.dart';
part 'get_doctor_name_state.dart';
part 'get_doctor_name_bloc.freezed.dart';

class GetDoctorNameBloc extends Bloc<GetDoctorNameEvent, GetDoctorNameState> {
  GetDoctorNameBloc() : super(_Initial()) {
    on<GetDoctorNameEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              body: event.reqBody, procedure: Api.getDoctorName);
          log("Get Doctor Name Api Response ${response.statusCode}");
          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body);
            List<GetDoctorName> departmentName =
                GetDoctorName.fromMapList(responseData);

            emit(_Sucess(departmentName));
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
        log("Get Doctor Name Api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
