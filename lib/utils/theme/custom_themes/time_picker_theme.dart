import 'package:flutter/material.dart';

class TTimePickerTheme {
  TTimePickerTheme._();

  static TimePickerThemeData lightTimePickerTheme = TimePickerThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    helpTextStyle: const TextStyle(
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
