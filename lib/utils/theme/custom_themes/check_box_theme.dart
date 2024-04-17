import 'package:flutter/material.dart';

class TCheckBoxTheme {
  TCheckBoxTheme._();

  static CheckboxThemeData lightCheckBoxTheme = CheckboxThemeData(
    visualDensity: VisualDensity.compact,
    checkColor: MaterialStateProperty.all(Colors.white),
  );
  static CheckboxThemeData darkCheckBoxTheme = const CheckboxThemeData();
}
