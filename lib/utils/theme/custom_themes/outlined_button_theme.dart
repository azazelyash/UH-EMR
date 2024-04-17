import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TOutlineButtonThemeData {
  TOutlineButtonThemeData._();

  static OutlinedButtonThemeData lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ConstantColors.kPrimaryColor,
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        // fontFamily: Constants.primaryFontFamily,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      side: const BorderSide(
        color: Color(0xff398CEF),
      ),
    ),
  );
  static OutlinedButtonThemeData darkOutlineButtonTheme = const OutlinedButtonThemeData();
}
