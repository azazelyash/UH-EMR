import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    // Display
    displayLarge: const TextStyle().copyWith(fontSize: 57, fontWeight: FontWeight.w400),
    displayMedium: const TextStyle().copyWith(fontSize: 45, fontWeight: FontWeight.w400),
    displaySmall: const TextStyle().copyWith(fontSize: 12, fontWeight: FontWeight.w400),

    // Heading
    headlineLarge:
        const TextStyle().copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: ConstantColors.kHeadlingColor),
    headlineMedium:
        const TextStyle().copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: ConstantColors.kHeadlingColor),
    headlineSmall:
        const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: ConstantColors.kHeadlingColor),

    // Title
    titleLarge: const TextStyle().copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
    titleMedium: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
    titleSmall: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),

    // Body
    bodyLarge: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black87),
    bodyMedium: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
    bodySmall: const TextStyle().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black87),
  );

  static TextTheme darkTextTheme = TextTheme(
    // Display
    displayLarge: const TextStyle().copyWith(fontSize: 57, fontWeight: FontWeight.w400),
    displayMedium: const TextStyle().copyWith(fontSize: 45, fontWeight: FontWeight.w400),
    displaySmall: const TextStyle().copyWith(fontSize: 36, fontWeight: FontWeight.w400),

    // Heading
    headlineLarge: const TextStyle().copyWith(fontSize: 32, fontWeight: FontWeight.w400),
    headlineMedium: const TextStyle().copyWith(fontSize: 28, fontWeight: FontWeight.w400),
    headlineSmall: const TextStyle().copyWith(fontSize: 24, fontWeight: FontWeight.w400),

    // Title
    titleLarge: const TextStyle().copyWith(fontSize: 22, fontWeight: FontWeight.w400),
    titleMedium: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w500),
    titleSmall: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w500),

    // Body
    bodyLarge: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: const TextStyle().copyWith(fontSize: 12, fontWeight: FontWeight.w400),
  );
}
