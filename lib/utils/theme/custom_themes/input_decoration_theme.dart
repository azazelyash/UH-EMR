import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TInputDecorationThemeData {
  TInputDecorationThemeData._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: const TextStyle(color: Colors.black38, fontSize: 16.0, fontWeight: FontWeight.w600),
    labelStyle: const TextStyle(color: Colors.black38, fontSize: 16.0, fontWeight: FontWeight.w600),
    errorStyle: const TextStyle(color: ConstantColors.kErrorColor, fontSize: 14.0, fontWeight: FontWeight.w500),
    floatingLabelStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: ConstantColors.kErrorColor),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: ConstantColors.kErrorColor),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xff398CEF)),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black38),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
    ),
  );
  static InputDecorationTheme darkInputDecorationTheme = const InputDecorationTheme();
}
