
import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextTheme textTheme = TextTheme(
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  );

  static TextStyle get appBarTitle => textTheme.titleLarge!.copyWith(color: const Color(0xFF0B1223));
  static TextStyle get messageBody => textTheme.bodyLarge!.copyWith(color: const Color(0xFF0B1223));
  static TextStyle get messageSecondary => textTheme.bodyMedium!.copyWith(color: const Color(0xFF6B7280));
}
