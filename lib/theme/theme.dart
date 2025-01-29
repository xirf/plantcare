import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.green,
        accentColor: AppColors.accentColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.appBarForegroundColor,
        elevation: 0,
      ),
      scaffoldBackgroundColor: AppColors.backgroundColor,
    );
  }
}
