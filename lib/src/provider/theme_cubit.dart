// import 'package:airmid/src/constant/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ThemeCubit extends Cubit<ThemeMode> {
//   ThemeCubit() : super(ThemeMode.dark);

//   ThemeMode get themeMode => state;

//   bool get isDarkTheme => state == ThemeMode.dark;

//   /// Method to change theme
//   void changeTheme([ThemeMode? theme]) {
//     if (theme != null) {
//       emit(theme);
//       return;
//     }
//     if (state == ThemeMode.light) {
//       emit(ThemeMode.dark);
//     } else {
//       emit(ThemeMode.light);
//     }
//   }

//   /// Default light theme
//   ThemeData get lightTheme => Themeconfig.light;

//   /// Default dark theme
//   ThemeData get darkTheme => Themeconfig.dark;
// }
