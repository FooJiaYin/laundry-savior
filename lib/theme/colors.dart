import 'package:flutter/material.dart';

class ThemeColors {
  static const primaryColor = blue;
  static const primaryLight = Color(0xFFE6F3F5);
  static const primaryDark = Color(0xFF00727C);
  static const secondaryColor = royalBlue;
  static const textColor = grey;
  static const backgroundColor = Color(0xFFF2F4F7);
  static const blue = Color(0xFF3A9FE9);
  static const royalBlue = Color(0xFF547EEC);
  static const green = Color(0xFF58C789);
  static const cyan = Color(0xFF47B1BE);
  static const magenta = Color(0xFFD83496);
  static const pink = Color(0xFFEC54AF);
  static const coral = Color(0xFFED7474);
  static const grey = Color(0xFF949FBB);
  static const grey30 = Color(0x4C949FBB);
  static const lightGrey = Color(0xFFD6DCEC);
  static const darkGrey = Color(0xFF6B7897);
  static const primaryGradient = blueLinearGradient;
  static const blueLinearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [blue, royalBlue],
  );
  static const blueRingGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blue, royalBlue],
  );
  static const blueRadialGradient = RadialGradient(
    colors: [blue, royalBlue],
  );
  static const pinkLinearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [coral, magenta],
  );
  static const pinkRingGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [coral, magenta],
  );
  static const pinkRadialGradient = RadialGradient(
    colors: [magenta, coral],
  );
  static const greenLinearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [green, cyan],
  );
  static const greenRingGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [green, cyan],
  );
  var greyRadialGradient = RadialGradient(
    colors: [grey.withAlpha(64), grey.withAlpha(77)],
  );
  var darkGreyRadialGradient = RadialGradient(
    colors: [darkGrey.withAlpha(161), darkGrey.withAlpha(87)],
  );
}
