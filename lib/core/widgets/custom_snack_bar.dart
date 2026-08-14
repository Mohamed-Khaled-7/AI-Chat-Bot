import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

void CustomSnackBar({
  required BuildContext context,
  required String message,
  required Color? backgroundColor,
  required IconData icons,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icons, color: AppColors.white, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Expanded(
              child: Text(
                message,
                style: GoogleFonts.poppins(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
               ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      shape: StadiumBorder(),
      duration: const Duration(seconds: 1),
    ),
  );
}

