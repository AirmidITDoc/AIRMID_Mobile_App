part of 'sign_in_bloc.dart';

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.signIn(Map<String, dynamic> signinData) = _SignIn;
}
