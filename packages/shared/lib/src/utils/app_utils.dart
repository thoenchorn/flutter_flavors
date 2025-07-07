import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// General app utility functions
class AppUtils {
  AppUtils._();

  /// Check if running on mobile platform
  static bool get isMobile => !kIsWeb && (Platform.isIOS || Platform.isAndroid);

  /// Check if running on desktop platform
  static bool get isDesktop =>
      !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS);

  /// Check if running on web
  static bool get isWeb => kIsWeb;

  /// Get platform name
  static String get platformName {
    if (kIsWeb) return 'Web';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isAndroid) return 'Android';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isLinux) return 'Linux';
    if (Platform.isMacOS) return 'macOS';
    return 'Unknown';
  }

  /// Hide keyboard
  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  /// Show keyboard
  static void showKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  /// Vibrate device (if supported)
  static void vibrate() {
    if (isMobile) {
      HapticFeedback.lightImpact();
    }
  }

  /// Heavy vibration
  static void vibrateHeavy() {
    if (isMobile) {
      HapticFeedback.heavyImpact();
    }
  }

  /// Selection vibration
  static void vibrateSelection() {
    if (isMobile) {
      HapticFeedback.selectionClick();
    }
  }

  /// Copy text to clipboard
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  /// Get text from clipboard
  static Future<String?> getFromClipboard() async {
    final data = await Clipboard.getData('text/plain');
    return data?.text;
  }
}
