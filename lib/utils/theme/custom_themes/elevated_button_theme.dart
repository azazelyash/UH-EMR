import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: ConstantColors.kPrimaryColor,
      padding: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        // fontFamily: Constants.primaryFontFamily,
      ),
    ),
  );
  static ElevatedButtonThemeData darkElevatedButtonTheme = const ElevatedButtonThemeData();
}
