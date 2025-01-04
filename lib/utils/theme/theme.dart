import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/theme/custom_themes/appbar_theme.dart';
import 'package:ecom_app/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:ecom_app/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:ecom_app/utils/theme/custom_themes/chip_theme.dart';
import 'package:ecom_app/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:ecom_app/utils/theme/custom_themes/outlined_theme.dart';
import 'package:ecom_app/utils/theme/custom_themes/text_field_theme.dart';
import 'package:ecom_app/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class EAppTheme {
  EAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: ETextTheme.lightTextTheme,
    chipTheme: EChipTheme.lightTChipTheme,
    appBarTheme: EAppBarTheme.lightAppBarTheme,
    checkboxTheme: ECheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: EBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: EElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: EOutLinedButtonTheme.lightOutLinedButtonTheme,
    inputDecorationTheme: ETextFormFieldTheme.lightImputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: EColors.dark,
    textTheme: ETextTheme.darkTextTheme,
    chipTheme: EChipTheme.darkTChipTheme,
    appBarTheme: EAppBarTheme.darkAppBarTheme,
    checkboxTheme: ECheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: EBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: EElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: EOutLinedButtonTheme.darkOutLinedButtonTheme,
    inputDecorationTheme: ETextFormFieldTheme.darkImputDecorationTheme,
  );
}
