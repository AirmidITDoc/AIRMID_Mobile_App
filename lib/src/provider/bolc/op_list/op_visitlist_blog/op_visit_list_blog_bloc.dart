import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/op_list/op_data_list.dart';
import 'package:airmid/src/service/api.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'op_visit_list_blog_event.dart';
part 'op_visit_list_blog_state.dart';
part 'op_visit_list_blog_bloc.freezed.dart';

class OpVisitListBlog extends Bloc<OpVisitListBlogEvent, OpVisitListBlogState> {
  OpVisitListBlog() : super(const _Initial()) {
    on<OpVisitListBlogEvent>((event, emit) async {
      try {
        if (event is _Started) {
          emit(const _Loading());
          final response = await ApiService.procedureApiCalling(
              body: {}, procedure: Api.opdList);
          log("Api Response ${response.statusCode}");
          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body);
            List<OpDataList> opVisitDataList = responseData
                .map((e) => OpDataList.fromMap(e as Map<String, dynamic>))
                .toList();

            emit(_Sucess(opVisitDataList));
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
