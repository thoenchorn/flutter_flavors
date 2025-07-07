import 'package:flutter/material.dart';

/// A utility class that holds predefined spacing values and [SizedBox] widgets.
class AppSpacing {
  AppSpacing._(); // Private constructor to prevent instantiation

  // --- Double Values for Spacing ---

  /// Extra extra small spacing value (2.0).
  static const double xxs = 2.0;

  /// Extra small spacing value (4.0).
  static const double xs = 4.0;

  /// Small spacing value (8.0).
  static const double sm = 8.0;

  /// Medium spacing value (12.0).
  static const double md = 12.0;

  /// Large spacing value (16.0).
  static const double lg = 16.0;

  /// Extra large spacing value (24.0).
  static const double xl = 24.0;

  /// Double extra large spacing value (32.0).
  static const double xxl = 32.0;

  /// Triple extra large spacing value (48.0).
  static const double xxxl = 48.0;

  // --- SizedBox Widgets for Width ---

  /// A [SizedBox] with a width of extra small size (`xs`).
  static const SizedBox widthXS = SizedBox(width: AppSpacing.xs);

  /// A [SizedBox] with a width of small size (`sm`).
  static const SizedBox widthSM = SizedBox(width: AppSpacing.sm);

  /// A [SizedBox] with a width of medium size (`md`).
  static const SizedBox widthMD = SizedBox(width: AppSpacing.md);

  /// A [SizedBox] with a width of large size (`lg`).
  static const SizedBox widthLG = SizedBox(width: AppSpacing.lg);

  /// A [SizedBox] with a width of extra large size (`xl`).
  static const SizedBox widthXL = SizedBox(width: AppSpacing.xl);

  /// A [SizedBox] with a width of double extra large size (`xxl`).
  static const SizedBox widthXXL = SizedBox(width: AppSpacing.xxl);

  /// A [SizedBox] with a width of triple extra large size (`xxxl`).
  static const SizedBox widthXXXL = SizedBox(width: AppSpacing.xxxl);

  // --- SizedBox Widgets for Height ---

  /// A [SizedBox] with a height of extra small size (`xs`).
  static const SizedBox heightXS = SizedBox(height: AppSpacing.xs);

  /// A [SizedBox] with a height of small size (`sm`).
  static const SizedBox heightSM = SizedBox(height: AppSpacing.sm);

  /// A [SizedBox] with a height of medium size (`md`).
  static const SizedBox heightMD = SizedBox(height: AppSpacing.md);

  /// A [SizedBox] with a height of large size (`lg`).
  static const SizedBox heightLG = SizedBox(height: AppSpacing.lg);

  /// A [SizedBox] with a height of extra large size (`xl`).
  static const SizedBox heightXL = SizedBox(height: AppSpacing.xl);

  /// A [SizedBox] with a height of double extra large size (`xxl`).
  static const SizedBox heightXXL = SizedBox(height: AppSpacing.xxl);

  /// A [SizedBox] with a height of triple extra large size (`xxxl`).
  static const SizedBox heightXXXL = SizedBox(height: AppSpacing.xxxl);
}