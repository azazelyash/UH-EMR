import 'package:flutter/material.dart';

class TColorScheme {
  TColorScheme._();

  static ColorScheme lightColorScheme = ColorScheme(
    error: const Color(0xffEC3E3E),
    onError: Colors.white,
    surface: Colors.white,
    secondary: Colors.blue,
    onPrimary: Colors.white,
    background: Colors.white,
    onSecondary: Colors.white,
    surfaceTint: Colors.white,
    onBackground: Colors.white,
    brightness: Brightness.light,
    onSurface: Colors.grey.shade800,
    primary: const Color(0xff398CEF),
  );
}
