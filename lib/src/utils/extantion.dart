import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension Context on BuildContext {
  /// The same of [MediaQuery.of(context).size]
  Size get size => MediaQuery.of(this).size;

  /// The same of [MediaQuery.of(context).size.height]
  double get height => MediaQuery.of(this).size.height;

  /// The same of [MediaQuery.of(context).size.width]
  double get width => MediaQuery.of(this).size.width;

  /// similar to [Theme.of(context)]
  ThemeData get theme => Theme.of(this);

  /// similar to [Theme.of(context).colorScheme]
  ColorScheme get color => Theme.of(this).colorScheme;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get primaryColor => Theme.of(this).primaryColor;
}

extension FormatNumberExtension on String {
  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}

bool emailValidation({required String email}) {
  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  return emailRegExp.hasMatch(email);
}

bool passwordValidation({required String password}) {
  RegExp passwordRegExp =
      RegExp(r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  return passwordRegExp.hasMatch(password);
}

extension DateTimeFormatExtension on DateTime {
  String toFormattedString() {
    try {
      return DateFormat('dd-MM-yyyy').format(this);
    } catch (e) {
      print('Error formatting date: $e');
      return '';
    }
  }
}

extension AgeStringExtension on String {
  String formatAge(String years, String months, String days) {
    String trimAndReplaceSpaces(String input) {
      return input.trim().replaceAll(RegExp(r'\s+'), '');
    }

    final formattedYears = trimAndReplaceSpaces(years);
    final formattedMonths = trimAndReplaceSpaces(months);
    final formattedDays = trimAndReplaceSpaces(days);

    return '$formattedYears y $formattedMonths m $formattedDays d';
  }
}
