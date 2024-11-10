import 'package:airmid/src/model/auth/signin_model.dart';
import 'package:flutter/foundation.dart';

class UserDataUtils {
  factory UserDataUtils() {
    return _constant;
  }
  UserDataUtils._internal() {
    if (kDebugMode) {
      print('[UserDataUtils] init called');
    }
  }

  static final UserDataUtils _constant = UserDataUtils._internal();

  /// User data from login response
  static LoginData _userData = LoginData();
  static LoginData get userData => _userData;

  /// Set user data to [_userData]
  void setUserData(LoginData result) {
    _userData = result;
  }
}
