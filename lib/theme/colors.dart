import 'package:flutter/material.dart';

class ThemeColors {
  static const primaryColor = cyan;
  static const primaryLight = Color(0xFFE6F3F5);
  static const primaryDark = Color(0xFF00727C);
  static const secondaryColor = purple;
  static const textColor = Color(0xFF505050);
  static const backgroundColor = Color(0xFFFAFAFA);
  static const cyan = Color(0xFF83C9C3);
  static const purple = Color(0xFFAC92CC);
  static const primaryGradient = greenPurpleGradient;
  static const greenPurpleGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [cyan, purple],
  );
}
