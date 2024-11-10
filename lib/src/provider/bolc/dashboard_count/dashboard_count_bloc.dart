import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/dashboard/dashboard_count.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_count_event.dart';
part 'dashboard_count_state.dart';
part 'dashboard_count_bloc.freezed.dart';

class DashboardCountBloc
    extends Bloc<DashboardCountEvent, DashboardCountState> {
  DashboardCountBloc() : super(const _Initial()) {
    on<DashboardCountEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              body: {}, procedure: Api.dashboardCount);
          log("dashboard Data Api Response ${response.statusCode}");
          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body);
            List<DashboardCount> admitList =
                responseData.map((e) => DashboardCount.fromMap(e)).toList();

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
        log("Dashboard list api error ${e.toString()}");
        emit(_Error(e.toString()));
      }
    });
  }
}
