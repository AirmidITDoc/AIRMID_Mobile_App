import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/model/auth/signin_model.dart';
import 'package:airmid/src/service/resr_api.dart';
import 'package:airmid/src/utils/hive/hive.dart';
import 'package:airmid/src/widget/user_data_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_bloc.freezed.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const _Initial()) {
    on<SignInEvent>((event, emit) async {
      try {
        if (event is _SignIn) {
          emit(const _Loading());
          final response = await ApiService.loginApi(event.signinData);
          log("Api Response ${response.statusCode}");
          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            log("Login Data: ${event.signinData}");
            log("API Response Body: $jsonResponse"); // Ensure response structure here

            // Check and parse data from jsonResponse
            if (jsonResponse.containsKey('token')) {
              // Assuming your token retrieval logic is correct
              HiveUtils.set(HiveKeys.token, jsonResponse['token']);
              final data = LoginData.fromMap(json.decode(response.body));
              HiveUtils.set(HiveKeys.firstName, data.user?.firstName ?? "");
              HiveUtils.set(HiveKeys.email, data.user?.mailId ?? "");
              HiveUtils.set(HiveKeys.lastName, data.user?.lastName ?? "");
              HiveUtils.set(HiveKeys.userName, data.user?.userName ?? "");
              HiveUtils.set(HiveKeys.userId, data.user?.id ?? 0);
              UserDataUtils().setUserData(data);
              // HiveUtils.set(HiveKeys.userData, data);
              emit(const _Success());
            } else {
              emit(const _Error("Token not found in response"));
            }
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
