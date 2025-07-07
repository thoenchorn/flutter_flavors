/// Application-level constants
class AppConstants {
  AppConstants._();

  // App information
  static const String appName = 'Flutter Flavors';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // Storage keys
  static const String userTokenKey = 'user_token';
  static const String userPreferencesKey = 'user_preferences';
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';

  // Timeouts
  static const Duration networkTimeout = Duration(seconds: 30);
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration animationDuration = Duration(milliseconds: 300);

  // Limits
  static const int maxFileUploadSize = 10 * 1024 * 1024; // 10MB
  static const int maxUsernameLength = 50;
  static const int maxEmailLength = 100;
  static const int minPasswordLength = 8;

  // Regex patterns
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^\+?[\d\s\-\(\)]{8,}$';
  static const String strongPasswordPattern =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$';
}
