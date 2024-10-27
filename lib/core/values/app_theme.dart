import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stu_teach/core/values/app_colors.dart';




final appTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: AppColors.primaryColor,
  ),
  fontFamily: 'Inter',
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.white,
    iconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    centerTitle: true,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 30, fontWeight: FontWeight.w700, color: AppColors.black),
    displayMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black),
    displaySmall: TextStyle(
        fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.grey3),
    headlineMedium: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.black),
    headlineLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.black),
    headlineSmall: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.black),
    titleLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.black),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    ),
    titleSmall: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.black),
    bodyLarge: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.grey4),
    bodyMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.black),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.grey3,
    ),
  ),
  scaffoldBackgroundColor: AppColors.white,
  cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.light),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.red,
  primaryColor: AppColors.primaryColor,
  cardColor: AppColors.white,
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  }),
);

