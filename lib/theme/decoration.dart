import 'package:flutter/material.dart';

import 'colors.dart';

class ThemeDecoration {
  static List<BoxShadow> shadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 1,
      blurRadius: 5,
      offset: const Offset(0, 4), // changes position of shadow
    ),
  ]; // changes position of shadow
  static const List<BoxShadow> neumorphicShadow = [
    BoxShadow(
      color: ThemeColors.grey30,
      blurRadius: 12,
      offset: Offset(4, 4), // changes position of shadow
    ),
    BoxShadow(
      color: Colors.white,
      blurRadius: 10,
      offset: Offset(-4, -4), // changes position of shadow
    ),
  ];
  static const List<BoxShadow> neumorphicShadowPressed = [
    BoxShadow(
      color: ThemeColors.backgroundColor,
      spreadRadius: -6.0,
      blurRadius: 6.0,
      offset: Offset(-0.5, -0.5), // changes position of shadow
    ),
  ];
  static List<BoxShadow> circleShadow = [
    BoxShadow(
      color: ThemeColors.grey.withOpacity(0.38),
      offset: const Offset(1, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
    const BoxShadow(
      color: Colors.white,
      offset: Offset(-1, -2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];
  static List<BoxShadow> ringShadow = [
    BoxShadow(
      color: ThemeColors.grey.withOpacity(0.38),
      offset: const Offset(0,0),
      blurRadius: 4,
      spreadRadius: 1,
    ),
  ];
}
