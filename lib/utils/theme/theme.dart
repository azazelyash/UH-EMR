import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'custom_themes/app_bar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/check_box_theme.dart';
import 'custom_themes/color_scheme.dart';
import 'custom_themes/date_picker_theme.dart';
import 'custom_themes/dialog_theme.dart';
import 'custom_themes/divider_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/input_decoration_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/popup_menu_theme.dart';
import 'custom_themes/text_theme.dart';
import 'custom_themes/time_picker_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    scaffoldBackgroundColor: Colors.white,
    // fontFamily: Constants.primaryFontFamily,
    colorScheme: TColorScheme.lightColorScheme,
    dialogTheme: TDialogTheme.lightDialogTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    dividerTheme: TDividerTheme.lightDividerTheme,
    checkboxTheme: TCheckBoxTheme.lightCheckBoxTheme,
    timePickerTheme: TTimePickerTheme.lightTimePickerTheme,
    datePickerTheme: TDatePickerTheme.lightDatePickerTheme,
    popupMenuTheme: TPopupMenuTheme.lightPopupMenuThemeData,
    bottomSheetTheme: TBottomSheetThemeData.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlineButtonThemeData.lightOutlineButtonTheme,
    inputDecorationTheme: TInputDecorationThemeData.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: Constants.primaryFontFamily,
    textTheme: TTextTheme.lightTextTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckBoxTheme.darkCheckBoxTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlineButtonThemeData.darkOutlineButtonTheme,
    inputDecorationTheme: TInputDecorationThemeData.darkInputDecorationTheme,
  );
}
