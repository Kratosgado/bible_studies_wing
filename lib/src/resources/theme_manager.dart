import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors of the app
      // primaryColor: ColorManager.primary,
      // primaryColorLight: ColorManager.primaryOpacity70,
      // primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      colorScheme: ColorScheme.dark(
        background: ColorManager.bgColor,
        primary: Colors.blue.shade700,
        onPrimary: ColorManager.lightGrey,
        secondary: ColorManager.secondaryColor,
        onSecondary: ColorManager.grey2,
      ),
      // ripple color
      splashColor: Colors.teal,
      // will be used incase of disabled button for example
      secondaryHeaderColor: ColorManager.grey,
      // card view theme
      cardTheme: CardTheme(
          color: Colors.blueAccent.shade100,
          shadowColor: ColorManager.grey,
          elevation: Spacing.s4,
          shape: const StadiumBorder()),
      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.blue.shade700,
          shape: const StadiumBorder(),
          elevation: Spacing.s8,
          shadowColor: Colors.blue.shade400,
          ),
      // Button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: Colors.blue.shade700,
          splashColor: ColorManager.bgColor),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
            splashFactory: InkSparkle.splashFactory),
      ),
      // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        prefixIconColor: Colors.blue.shade100,
        suffixIconColor: Colors.blue.shade100,

        contentPadding: const EdgeInsets.all(Spacing.s20),
        // hint style
        iconColor: Colors.blue.shade200,

        // label style
        // error style

        // enabled border
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(80),
            borderSide: BorderSide(color: Colors.teal.shade300)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(80),
            borderSide: BorderSide(color: Colors.teal.shade300)),
        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade500, width: Spacing.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(Spacing.s8))),

        // error border
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error, width: Spacing.s1_5),
          borderRadius: const BorderRadius.all(
            Radius.circular(Spacing.s8),
          ),
        ),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary, width: Spacing.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(Spacing.s8))),
      ));
}
