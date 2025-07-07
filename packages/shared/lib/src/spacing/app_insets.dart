import 'package:flutter/widgets.dart';
import 'app_spacing.dart';

/// A utility class for creating consistent [EdgeInsets] for padding and margins.
class AppInsets {
  AppInsets._(); // Prevents instantiation

  /// An [EdgeInsets] with zero value for all sides.
  static const EdgeInsets zero = EdgeInsets.zero;

  /// An [EdgeInsets] with extra small spacing (`AppSpacing.xs`) for all sides.
  static const EdgeInsets allXXS = EdgeInsets.all(AppSpacing.xxs);

  /// An [EdgeInsets] with extra small spacing (`AppSpacing.xs`) for all sides.
  static const EdgeInsets allXS = EdgeInsets.all(AppSpacing.xs);

  /// An [EdgeInsets] with small spacing (`AppSpacing.sm`) for all sides.
  static const EdgeInsets allSM = EdgeInsets.all(AppSpacing.sm);

  /// An [EdgeInsets] with medium spacing (`AppSpacing.md`) for all sides.
  static const EdgeInsets allMD = EdgeInsets.all(AppSpacing.md);

  /// An [EdgeInsets] with large spacing (`AppSpacing.lg`) for all sides.
  static const EdgeInsets allLG = EdgeInsets.all(AppSpacing.lg);

  /// An [EdgeInsets] with extra large spacing (`AppSpacing.xl`) for all sides.
  static const EdgeInsets allXL = EdgeInsets.all(AppSpacing.xl);

  /// An [EdgeInsets] with double extra large spacing (`AppSpacing.xxl`) for all sides.
  static const EdgeInsets allXXL = EdgeInsets.all(AppSpacing.xxl);

  /// An [EdgeInsets] with triple extra large spacing (`AppSpacing.xxxl`) for all sides.
  static const EdgeInsets allXXXL = EdgeInsets.all(AppSpacing.xxxl);

  /// Creates uniform insets for all sides with a custom value.
  static EdgeInsets all(double value) => EdgeInsets.all(value);

  /// Creates horizontal insets with a custom value.
  static EdgeInsets horizontal(double value) => EdgeInsets.symmetric(horizontal: value);

  /// Creates vertical insets with a custom value.
  static EdgeInsets vertical(double value) => EdgeInsets.symmetric(vertical: value);

  /// Creates symmetric insets for vertical and horizontal sides.
  ///
  /// Example: `AppInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.md)`
  static EdgeInsets symmetric({
    double vertical = 0.0,
    double horizontal = 0.0,
  }) {
    return EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal);
  }

  /// Creates insets for only the specified sides.
  ///
  /// Example: `AppInsets.only(left: AppSpacing.md, bottom: 5.0)`
  static EdgeInsets only({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
  }
}