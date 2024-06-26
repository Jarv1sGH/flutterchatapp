import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  Color get iconColor {
    return Theme.of(this).brightness == Brightness.dark
        ? Colors.white54
        : Colors.black54;
  }

  Color get primaryIconColor {
    return Colors.deepPurple;
  }

  Color get secondaryTextColor {
    return Theme.of(this).brightness == Brightness.dark
        ? Colors.white54
        : Colors.black54;
  }
}
