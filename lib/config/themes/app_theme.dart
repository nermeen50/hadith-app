import 'package:flutter/material.dart';
import 'package:hadith_app/core/utils/app_colors.dart';
import 'package:hadith_app/core/utils/app_strings.dart';

ThemeData appTheme() {
  return ThemeData(
      listTileTheme: ListTileThemeData(
        textColor: AppColors.white,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      primaryColor: AppColors.primary,
      fontFamily: AppStrings.appFontFamily,
      brightness: Brightness.light,
      hintColor: AppColors.offWhite,
      backgroundColor: AppColors.white,
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
              color: AppColors.black,
              height: 1.3,
              fontSize: 22,
              fontWeight: FontWeight.bold)));
}
