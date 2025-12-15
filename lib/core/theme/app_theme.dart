import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    final textTheme = GoogleFonts.urbanistTextTheme(base.textTheme).copyWith(
      displaySmall: GoogleFonts.urbanist(
        fontWeight: FontWeight.bold,
        fontSize: 28,
        color: AppColors.textPrimary,
      ),
      titleMedium: GoogleFonts.urbanist(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: AppColors.textPrimary,
      ),
      bodyLarge: GoogleFonts.urbanist(
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
      bodyMedium: GoogleFonts.urbanist(
        fontSize: 14,
        color: AppColors.textSecondary,
      ),
      labelLarge: GoogleFonts.urbanist(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.white,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.scaffold,
        background: AppColors.background,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: textTheme.bodyMedium,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.lg,
          vertical: AppSizes.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          ),
          textStyle: textTheme.labelLarge,
          backgroundColor: AppColors.primary,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.scaffold,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        ),
      ),
    );
  }
}
