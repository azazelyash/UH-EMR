import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TPopupMenuTheme {
  TPopupMenuTheme._();

  static PopupMenuThemeData lightPopupMenuThemeData = PopupMenuThemeData(
    surfaceTintColor: Colors.white,
    position: PopupMenuPosition.under,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    textStyle: const TextStyle(
      color: ConstantColors.kHeadlingColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );
}
