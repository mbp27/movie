import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/helpers/fonts.gen.dart';
import 'package:movie/presentation/components/material_color_generator.dart';
import 'package:movie/presentation/designs/app_color.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColor.primary,
    ),
    brightness: Brightness.light,
    fontFamily: FontFamily.archivo,
    primaryColor: AppColor.primary,
    primarySwatch: MaterialColorGenerator.from(AppColor.primary),
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: false,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData dark = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: AppColor.primary,
    ),
    brightness: Brightness.dark,
    fontFamily: FontFamily.archivo,
    primaryColor: AppColor.primary,
    primarySwatch: MaterialColorGenerator.from(AppColor.primary),
    scaffoldBackgroundColor: Colors.black,
    useMaterial3: false,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static void setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness:
          themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor:
          themeMode == ThemeMode.light ? Colors.white : Colors.black,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}
