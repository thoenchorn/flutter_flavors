import 'package:flutter/material.dart';

/// UI-related constants for consistent design
class UIConstants {
  UIConstants._();

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border radius
  static const double radiusXS = 4.0;
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusRound = 50.0;

  // Icon sizes
  static const double iconXS = 16.0;
  static const double iconSM = 20.0;
  static const double iconMD = 24.0;
  static const double iconLG = 32.0;
  static const double iconXL = 48.0;

  // Font sizes
  static const double fontXS = 12.0;
  static const double fontSM = 14.0;
  static const double fontMD = 16.0;
  static const double fontLG = 18.0;
  static const double fontXL = 20.0;
  static const double fontXXL = 24.0;
  static const double fontTitle = 28.0;
  static const double fontHeading = 32.0;

  // Button heights
  static const double buttonHeightSM = 32.0;
  static const double buttonHeightMD = 44.0;
  static const double buttonHeightLG = 56.0;

  // Common paddings
  static const EdgeInsets paddingAll = EdgeInsets.all(spacingMD);
  static const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(
    horizontal: spacingMD,
  );
  static const EdgeInsets paddingVertical = EdgeInsets.symmetric(
    vertical: spacingMD,
  );
  static const EdgeInsets paddingPage = EdgeInsets.all(spacingLG);

  // Common margins
  static const EdgeInsets marginAll = EdgeInsets.all(spacingMD);
  static const EdgeInsets marginBottom = EdgeInsets.only(bottom: spacingMD);
  static const EdgeInsets marginTop = EdgeInsets.only(top: spacingMD);

  // Elevation levels
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationMax = 16.0;

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 600);
}
