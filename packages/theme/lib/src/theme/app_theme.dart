import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared/shared.dart';
import 'package:theme/theme.dart';

/// A custom theme class with shared configurations for light and dark modes.
///
/// This theme uses Material 3 and the Google Fonts 'Inter' typeface.
/// Redundant theme properties have been extracted into private helper methods
/// to improve readability and maintainability (Don't Repeat Yourself - DRY).
class AppTheme {
  AppTheme._();

  // Centralized constants for shared styles.
  static final _buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppSpacing.md),
  );

  static final _buttonPadding = AppInsets.symmetric(
    vertical: AppSpacing.sm,
    horizontal: AppSpacing.md,
  );

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
      filledButtonTheme: _getFilledButtonTheme(colorScheme: colorScheme),
      elevatedButtonTheme: _getElevatedButtonTheme(colorScheme: colorScheme),
      outlinedButtonTheme: _getOutlinedButtonTheme(colorScheme: colorScheme),
      cardTheme: _commonCardTheme,
      inputDecorationTheme: _getInputDecorationTheme(colorScheme: colorScheme),
      switchTheme: _getSwitchTheme(colorScheme: colorScheme),
      segmentedButtonTheme: _getSegmentedButtonTheme(colorScheme: colorScheme), // Added this line
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
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
      filledButtonTheme: _getFilledButtonTheme(colorScheme: colorScheme),
      elevatedButtonTheme: _getElevatedButtonTheme(colorScheme: colorScheme),
      outlinedButtonTheme: _getOutlinedButtonTheme(colorScheme: colorScheme),
      cardTheme: _commonCardTheme,
      inputDecorationTheme: _getInputDecorationTheme(colorScheme: colorScheme),
      switchTheme: _getSwitchTheme(colorScheme: colorScheme),
      segmentedButtonTheme: _getSegmentedButtonTheme(colorScheme: colorScheme), // Added this line
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    );
  }

  // --- Private Helper Methods for Shared Theme Properties ---

  /// Returns a shared [SegmentedButtonThemeData].
  static SegmentedButtonThemeData _getSegmentedButtonTheme({
    required ColorScheme colorScheme,
  }) {
    return SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        backgroundColor: colorScheme.surface,
        selectedBackgroundColor: colorScheme.secondaryContainer,
        selectedForegroundColor: colorScheme.onSecondaryContainer,
        foregroundColor: colorScheme.onSurface,
        side: BorderSide(color: colorScheme.outline),
        shape: _buttonShape,
      ),
    );
  }

  /// Returns a shared [FilledButtonThemeData].
  static FilledButtonThemeData _getFilledButtonTheme({
    required ColorScheme colorScheme,
  }) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: _buttonShape,
        padding: _buttonPadding,
      ),
    );
  }

  /// Returns a shared [SwitchThemeData].
  static SwitchThemeData _getSwitchTheme({required ColorScheme colorScheme}) {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.onPrimary;
        }
        return colorScheme.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.surfaceContainerHighest;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.transparent;
        }
        return colorScheme.outline;
      }),
    );
  }

  /// Returns a shared [ElevatedButtonThemeData].
  static ElevatedButtonThemeData _getElevatedButtonTheme({
    required ColorScheme colorScheme,
  }) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: _buttonShape,
        padding: _buttonPadding,
      ),
    );
  }

  /// Returns a shared [OutlinedButtonThemeData].
  static OutlinedButtonThemeData _getOutlinedButtonTheme({
    required ColorScheme colorScheme,
  }) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.primary),
        shape: _buttonShape,
        padding: _buttonPadding,
      ),
    );
  }

  /// Returns a shared [InputDecorationTheme].
  static InputDecorationTheme _getInputDecorationTheme({
    required ColorScheme colorScheme,
  }) {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
    );
  }

  /// Returns a shared [CardThemeData].
  static final CardThemeData _commonCardTheme = CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.lg),
    ),
  );
}
