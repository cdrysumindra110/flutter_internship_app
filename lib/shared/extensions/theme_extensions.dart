import 'package:flutter/material.dart';

extension ThemeAwareColors on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get textColor => isDarkMode ? Colors.white : Colors.black87;

  Color get secondaryTextColor =>
      isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;

  Color get surfaceColor => isDarkMode ? const Color(0xFF1E1E2C) : Colors.white;

  Color get backgroundColor =>
      isDarkMode ? const Color(0xFF0D0D15) : Colors.white;

  Color get dividerColor =>
      isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;

  Color get disabledColor =>
      isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400;

  Color get shimmerBaseColor =>
      isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;

  Color get shimmerHighlightColor =>
      isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100;
}
