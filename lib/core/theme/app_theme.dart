import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 0),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      secondary: AppColors.green,
      surface: AppColors.surface,
      surfaceContainerLowest: AppColors.background,
      error: AppColors.red,
      onPrimary: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
    ),
    useMaterial3: true,
  );
}
