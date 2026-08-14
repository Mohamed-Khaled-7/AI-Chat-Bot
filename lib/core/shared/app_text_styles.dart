import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextTheme textTheme = TextTheme(
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  );

  static TextStyle get appBarTitle =>
      textTheme.titleLarge!.copyWith(color: AppColors.textPrimary);
  static TextStyle get messageBody =>
      textTheme.bodyLarge!.copyWith(color: AppColors.textPrimary);
  static TextStyle get messageSecondary =>
      textTheme.bodyMedium!.copyWith(color: AppColors.textSecondary);
}
