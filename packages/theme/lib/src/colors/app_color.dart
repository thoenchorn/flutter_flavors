import 'package:flutter/material.dart';

/// A class that holds all the color constants for the application.
///
/// This class is designed to be a central repository for colors, making it easy
/// to manage and update the theme. It cannot be instantiated.
class AppColor {
  // This private constructor prevents the class from being instantiated.
  AppColor._();

  // --- Brand Colors ---
  /// The main brand color for the application. Hex: #FF8A65
  static const Color primary = Color(0xFFFF8A65);
  /// A color that is clear and legible when drawn on top of [primary] color.
  static const Color onPrimary = Colors.black;

  /// A lighter accent color, often used as a secondary brand color. Hex: #FFAB91
  static const Color secondary = Color(0xFFFFAB91);
  /// A color that is clear and legible when drawn on top of [secondary] color.
  static const Color onSecondary = Colors.black;

  ///secondary light
  static const Color secondaryLight = Color(0xFFFFAB91);
  ///secondary dark
  static const Color secondaryDark = Color(0xFF4E342E);


  // --- Light Theme Specific Colors ---
  //lightSurface
  static const Color surfaceLight = Color(0xFFFFF3EF);

  //onLightSurface
  static const Color onSurfaceLight = Colors.black;

  //surfaceDark
  static const Color surfaceDark = Color(0xFF1E1E1E);

  //onSurfaceDark
  static const Color onSurfaceDark = Colors.white;

  //lightBackground
  static const Color backgroundLight = Color(0xFFFFFFFF);
  // --- Dark Theme Specific Colors ---
  /// The deep, dark background color for dark mode scaffolds. Hex: #121212
  static const Color darkBackground = Color(0xFF121212);
  /// A color that is clear and legible when drawn on top of [darkBackground].
  static const Color onDarkBackground = Colors.white;

  /// A slightly lighter surface color for dark mode components. Hex: #1E1E1E
  static const Color darkSurface = Color(0xFF1E1E1E);
  /// A color that is clear and legible when drawn on top of [darkSurface].
  static const Color onDarkSurface = Colors.white;


  // --- Light Theme Specific Colors ---
  /// The background color for light mode scaffolds.
  static const Color lightBackground = Color(0xFFFFFFFF);
  /// A color that is clear and legible when drawn on top of [lightBackground].
  static const Color onLightBackground = Colors.black;


  // --- Neutral & Utility Colors ---
  /// A solid black color. Hex: #000000
  static const Color black = Colors.black;
  /// A solid white color. Hex: #FFFFFF
  static const Color white = Colors.white;
  /// A standard grey color, useful for secondary text or icons.
  static const Color grey = Colors.grey;
  /// A lighter grey color, often used for disabled elements or subtle borders.
  static const Color lightGrey = Color(0xFFA9A9A9);


  // --- Semantic Colors ---
  /// The color to use for input validation errors.
  static const Color error = Colors.redAccent;
  /// A color that is clear and legible when drawn on top of [error] color.
  static const Color onError = Colors.white;
}
