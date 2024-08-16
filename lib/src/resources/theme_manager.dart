import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme(BuildContext context) {
  return ThemeData(
      disabledColor: Colors.grey.shade400,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: Spacing.s20, color: Colors.black),
        titleLarge:
            TextStyle(fontWeight: FontWeight.bold, fontSize: Spacing.s28, color: Colors.black),
        titleMedium:
            TextStyle(fontWeight: FontWeight.bold, fontSize: Spacing.s20, color: Colors.black),
      ),
      colorScheme: ColorScheme.dark(
        surface: Colors.transparent,
        primary: ColorManager.mediumBlue,
        secondary: ColorManager.secondaryColor,
        // onSecondary: Colors.grey.shade400,
        tertiary: Colors.amber,
      ),

      // ripple color
      splashColor: Colors.teal,
      listTileTheme: ListTileThemeData(
        selectedTileColor: Colors.blueAccent.shade400,
        titleTextStyle: const TextStyle(fontSize: Spacing.s20),
        iconColor: Colors.white,
        selectedColor: Colors.white,
        contentPadding: const EdgeInsets.all(Spacing.s8),
        // shape: const StadiumBorder(),
      ),
      scaffoldBackgroundColor: Colors.transparent,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.deepBblue,
        splashColor: Colors.blueAccent.shade400,
        foregroundColor: Colors.white,
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
        // shadowColor: ColorManager.deepBblue,

        elevation: Spacing.s8,
      ),
      // App bar theme
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: Spacing.s8,
      ),
      // Button theme
      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: Colors.grey,
        buttonColor: ColorManager.deepBblue,
      ),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.deepBblue,
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
            splashFactory: InkSparkle.splashFactory),
      ),
      // input decoration theme (text form field)
      primaryTextTheme: TextTheme(
          bodyLarge: TextStyle(
            color: ColorManager.deepBblue,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(color: ColorManager.deepBblue)),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        prefixIconColor: ColorManager.deepBblue,
        suffixIconColor: Colors.blue.shade100,
        suffixStyle: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        fillColor: ColorManager.faintWhite,
        filled: true,
        contentPadding: const EdgeInsets.all(Spacing.s20),
        iconColor: Colors.blue.shade200,
        hintStyle: context.textTheme.titleLarge,
        labelStyle: TextStyle(
          color: ColorManager.deepBblue,
          fontSize: Spacing.s16,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.s15),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.s15),
          borderSide: BorderSide(color: ColorManager.deepBblue),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),

        // error border
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent.shade400, width: Spacing.s1_5),
          borderRadius: const BorderRadius.all(
            Radius.circular(Spacing.s8),
          ),
        ),
      ));
}
