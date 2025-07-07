/// String utility functions
class StringUtils {
  StringUtils._();

  /// Check if string is null or empty
  static bool isNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  /// Check if string is not null and not empty
  static bool isNotNullOrEmpty(String? value) {
    return !isNullOrEmpty(value);
  }

  /// Capitalize first letter of string
  static String capitalize(String value) {
    if (isNullOrEmpty(value)) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  /// Convert string to title case
  static String toTitleCase(String value) {
    if (isNullOrEmpty(value)) return value;
    return value.split(' ').map((word) => capitalize(word)).join(' ');
  }

  /// Remove all whitespace from string
  static String removeWhitespace(String value) {
    return value.replaceAll(RegExp(r'\s+'), '');
  }

  /// Truncate string to specified length with ellipsis
  static String truncate(String value, int maxLength, {String suffix = '...'}) {
    if (value.length <= maxLength) return value;
    return value.substring(0, maxLength - suffix.length) + suffix;
  }
}
