import 'package:flutter/material.dart';

class TDatePickerTheme {
  TDatePickerTheme._();

  static DatePickerThemeData lightDatePickerTheme = DatePickerThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    headerHelpStyle: const TextStyle(
      fontWeight: FontWeight.w500,
    ),
    cancelButtonStyle: TextButton.styleFrom(
      textStyle: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
    confirmButtonStyle: TextButton.styleFrom(
      textStyle: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
