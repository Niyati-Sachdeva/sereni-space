import 'package:flutter/material.dart';
import 'app_colors.dart';
class AppTheme {
  AppTheme._();

 
  static ThemeData get calmBlue => _buildTheme(
        primary: AppColors.calmBluePrimary,
        secondary: AppColors.calmBlueSecondary,
        surface: AppColors.calmBlueSurface,
        background: AppColors.calmBlueBackground,
      );

  static ThemeData get warmSunset => _buildTheme(
        primary: AppColors.sunsetPrimary,
        secondary: AppColors.sunsetSecondary,
        surface: AppColors.sunsetSurface,
        background: AppColors.sunsetBackground,
      );

  static ThemeData get forestGreen => _buildTheme(
        primary: AppColors.forestPrimary,
        secondary: AppColors.forestSecondary,
        surface: AppColors.forestSurface,
        background: AppColors.forestBackground,
      );

  static ThemeData get sleepLavender => _buildTheme(
        primary: AppColors.lavenderPrimary,
        secondary: AppColors.lavenderSecondary,
        surface: AppColors.lavenderSurface,
        background: AppColors.lavenderBackground,
      );


  static ThemeData _buildTheme({
    required Color primary,
    required Color secondary,
    required Color surface,
    required Color background,
  }) {
    return ThemeData(
      useMaterial3: true,

      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: AppColors.white,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        error: AppColors.error,
      ),

      scaffoldBackgroundColor: background,

      // Textpart
      textTheme: const TextTheme(
        displayMedium: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          height: 1.3,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          height: 1.6,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),

      // Cards 
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: surface,
      ),

      // Buttons match theme primary
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      dividerColor: AppColors.divider,
      dividerTheme: const DividerThemeData(
        thickness: 1,
        space: 1,
      ),
    );
  }
}