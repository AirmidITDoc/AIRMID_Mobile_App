// import 'package:airmid/src/constant/color.dart';
// import 'package:airmid/src/constant/font_sizes.dart';
// import 'package:airmid/src/utils/extantion.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Themeconfig {
//   Themeconfig._();

//   // Light theme
//   static ThemeData light = ThemeData(
//     useMaterial3: true,
//     // fontFamily: 'Helvetica',
//     // fontFamily: "RobotoCondensed",
//     primaryColor: ConstColor.primaryLight,
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: ConstColor.bgColorLight,
//     indicatorColor: ConstColor.primaryLight,
//     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//       backgroundColor: ConstColor.bgColorLight,
//     ),
//     inputDecorationTheme: _inputDecorationTheme,
//     iconTheme: const IconThemeData(
//       color: ConstColor.black,
//     ),
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.transparent,
//       surfaceTintColor: Colors.transparent,
//       elevation: 0.0,
//       systemOverlayStyle: SystemUiOverlayStyle.dark,
//     ),
//     textTheme: _textTheme,
//     // cardTheme: CardTheme(
//     //   margin: EdgeInsets.zero,
//     //   elevation: 0,
//     //   color: ConstColor.disabledLight,
//     //   surfaceTintColor: ConstColor.disabledLight,
//     //   clipBehavior: Clip.hardEdge,
//     //   shape: RoundedRectangleBorder(
//     //     side: const BorderSide(color: ConstColor.borderLight),
//     //     borderRadius: BorderRadius.circular(10),
//     //   ),
//     // ),
//     drawerTheme: const DrawerThemeData(
//       backgroundColor: ConstColor.bgColorLight,
//       surfaceTintColor: ConstColor.bgColorLight,
//       width: 264.0,
//       elevation: 2.0,
//     ),
//     dividerTheme: const DividerThemeData(
//       color: ConstColor.grey,
//     ),
//     tabBarTheme: const TabBarTheme(
//       dividerColor: ConstColor.primaryLight,
//       indicatorColor: ConstColor.primaryLight,
//       unselectedLabelColor: ConstColor.black,
//     ),
//     buttonTheme: ButtonThemeData(
//       buttonColor: Colors.blue, // Set the button color
//       disabledColor: Colors.grey, // Set the disabled button color
//       textTheme: ButtonTextTheme
//           .primary, // Set the text color to the primary theme color
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10)), // Set button shape
//       padding: const EdgeInsets.symmetric(
//         vertical: 12,
//         horizontal: 24,
//       ), // Set button padding
//     ),
//   );

//   // Dark theme
//   static ThemeData dark = ThemeData(
//     useMaterial3: true,
//     // fontFamily: 'Helvetica',
//     // fontFamily: "RobotoCondensed",
//     primaryColor: ConstColor.primaryDark,
//     brightness: Brightness.dark,
//     scaffoldBackgroundColor: ConstColor.bgColorDark,
//     indicatorColor: ConstColor.primaryDark,
//     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//       backgroundColor: Color(0xff302F32),
//     ),
//     iconTheme: const IconThemeData(
//       color: ConstColor.white,
//     ),
//     inputDecorationTheme: _darkInputDecorationTheme,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.transparent,
//       surfaceTintColor: Colors.transparent,
//       elevation: 0.0,
//       systemOverlayStyle: SystemUiOverlayStyle.light,
//     ),
//     textTheme: _textTheme,
//     // cardTheme: CardTheme(
//     //   margin: EdgeInsets.zero,
//     //   elevation: 0.0,
//     //   color: ConstColor.disabledDark,
//     //   surfaceTintColor: ConstColor.disabledDark,
//     //   clipBehavior: Clip.hardEdge,
//     //   shape: RoundedRectangleBorder(
//     //     side: const BorderSide(color: ConstColor.borderDark),
//     //     borderRadius: BorderRadius.circular(10),
//     //   ),
//     // ),
//     drawerTheme: const DrawerThemeData(
//       backgroundColor: ConstColor.bgColorDark,
//       surfaceTintColor: ConstColor.bgColorDark,
//       elevation: 2.0,
//       width: 264.0,
//     ),
//     dividerTheme: const DividerThemeData(
//       color: ConstColor.grey,
//     ),
//     tabBarTheme: const TabBarTheme(
//       dividerColor: ConstColor.primaryDark,
//       indicatorColor: ConstColor.primaryDark,
//       unselectedLabelColor: ConstColor.white,
//     ),
//   );

//   static final TextTheme _textTheme = TextTheme(
//     labelLarge: TextStyle(
//       fontSize: FontSizes.button,
//       fontWeight: FontWeight.w600,
//     ),
//     bodyLarge: TextStyle(
//       fontSize: FontSizes.body1,
//     ),
//     bodyMedium: TextStyle(
//       fontSize: FontSizes.body2,
//     ),
//     displayLarge: TextStyle(
//       fontSize: FontSizes.headline1,
//       fontWeight: FontWeight.bold,
//     ),
//     displayMedium: TextStyle(
//       fontSize: FontSizes.headline2,
//       fontWeight: FontWeight.bold,
//     ),
//     displaySmall: TextStyle(
//       fontSize: FontSizes.headline3,
//       fontWeight: FontWeight.bold,
//     ),
//     headlineMedium: TextStyle(
//       fontSize: FontSizes.headline4,
//       fontWeight: FontWeight.bold,
//     ),
//     headlineSmall: TextStyle(
//       fontSize: FontSizes.headline5,
//       fontWeight: FontWeight.bold,
//     ),
//     titleLarge: TextStyle(
//       fontSize: FontSizes.headline6,
//       fontWeight: FontWeight.bold,
//     ),
//     titleMedium: TextStyle(
//       fontSize: FontSizes.subtitle1,
//     ),
//     titleSmall: TextStyle(
//       fontSize: FontSizes.subtitle2,
//     ),
//     bodySmall: TextStyle(
//       fontSize: FontSizes.medium,
//     ),
//   );

//   static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: const BorderSide(),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: const BorderSide(),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: const BorderSide(),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: const BorderSide(),
//         ),
//         hintStyle: TextStyle(
//           // color: ConstColor.inputHintColor,
//           fontWeight: FontWeight.w500,
//           fontSize: 18.0.sp,
//         ),
//         filled: true,
//         fillColor: ConstColor.textFiledColor,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//       );

//   static InputDecorationTheme get _darkInputDecorationTheme =>
//       InputDecorationTheme(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0.r),
//           borderSide: const BorderSide(),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0.r),
//           borderSide: const BorderSide(),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0.r),
//           borderSide: const BorderSide(),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0.r),
//           borderSide: const BorderSide(),
//         ),
//         hintStyle: TextStyle(
//           // color: ConstColor.inputHintColor,
//           fontWeight: FontWeight.w500,
//           fontSize: 18.0.sp,
//         ),
//         errorStyle: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.w500),
//         filled: true,
//         fillColor: ConstColor.textFiledColor,
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
//       );

//   // Text styles
//   static TextStyle lightText(BuildContext context) => TextStyle(
//         fontSize: 14.0.sp,
//         fontWeight: FontWeight.w400,
//         color: context.isDarkMode
//             ? ConstColor.textColorDark
//             : ConstColor.textColorLight,
//       );

//   static TextStyle mediumText(BuildContext context) => TextStyle(
//         fontSize: 16.0.sp,
//         fontWeight: FontWeight.w500,
//         color: context.isDarkMode
//             ? ConstColor.textColorDark
//             : ConstColor.textColorLight,
//       );

//   static TextStyle largeText(BuildContext context) => TextStyle(
//         fontSize: 18.0.sp,
//         fontWeight: FontWeight.w500,
//         color: context.isDarkMode
//             ? ConstColor.textColorDark
//             : ConstColor.textColorLight,
//       );

//   static TextStyle titleText(BuildContext context) => TextStyle(
//         fontSize: 14.0.sp,
//         fontWeight: FontWeight.w500,
//         color: context.isDarkMode
//             ? ConstColor.textColorDark
//             : ConstColor.textColorLight,
//       );

//   static TextStyle subTitleText(BuildContext context) => TextStyle(
//         fontSize: 12.0.sp,
//         fontWeight: FontWeight.normal,
//         color: context.isDarkMode
//             ? ConstColor.textColorDark
//             : ConstColor.textColorLight,
//       );
//   static TextStyle hintText(BuildContext context) => TextStyle(
//         fontSize: 12.0.sp,
//         fontWeight: FontWeight.normal,
//         color: context.isDarkMode
//             ? Colors.white.withOpacity(0.7)
//             : ConstColor.grey,
//       );
// }
