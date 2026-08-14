import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> soft = [
    BoxShadow(
      color: AppColors.textMuted,
      blurRadius: 18,
      offset: Offset(0, 8),
    ),
  ];
}
