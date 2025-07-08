import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared/shared.dart';
import 'package:theme/theme.dart';

/// A custom theme class generated from a primary seed color.
///
/// This theme uses Material 3 (useMaterial3: true) and the Google Fonts
/// 'Inter' typeface for a modern and clean look.
class AppTheme {
  AppTheme._();

  /// Provides the complete [ThemeData] for light mode.
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColor.primary,
      onPrimary: Colors.white,
      secondary: AppColor.secondaryLight,
      onSecondary: Colors.white,
      surface: AppColor.surfaceLight,
      onSurface: AppColor.onSurfaceLight,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      primaryColor: colorScheme.primary,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.md),
          ),
          padding: AppInsets.symmetric(
            vertical: AppSpacing.sm,
            horizontal: AppSpacing.md,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.md),
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      ),
      textTheme: GoogleFonts.interTextTheme(),
    );
  }

  /// Provides the complete [ThemeData] for dark mode.
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.dark(
      primary: AppColor.primary,
      onPrimary: Colors.black,
      secondary: AppColor.secondaryDark,
      onSecondary: Colors.black,
      surface: AppColor.surfaceDark,
      onSurface: AppColor.onSurfaceDark,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.md),
          ),
          padding: AppInsets.symmetric(
            vertical: AppSpacing.sm,
            horizontal: AppSpacing.md,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.md),
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme, // Base dark text theme for proper color
      ),
    );
  }
}
