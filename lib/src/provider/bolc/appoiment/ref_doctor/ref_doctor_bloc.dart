import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/op_list/add_appoiment/ref_doctor.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ref_doctor_event.dart';
part 'ref_doctor_state.dart';
part 'ref_doctor_bloc.freezed.dart';

class RefDoctorBloc extends Bloc<RefDoctorEvent, RefDoctorState> {
  RefDoctorBloc() : super(_Initial()) {
    on<RefDoctorEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              body: {}, procedure: Api.refDoctor);
          log("Refrence Doctor Api Response ${response.statusCode}");
          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body);
            List<RefDoctor> refDoctor = responseData
                .map((e) => RefDoctor.fromMap(e as Map<String, dynamic>))
                .toList();

            emit(_Success(refDoctor));
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
        log("Refrence Doctor api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
