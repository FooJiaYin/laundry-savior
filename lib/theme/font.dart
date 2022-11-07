import 'package:flutter/material.dart';
import 'colors.dart';

class ThemeFont {
  static const fontFamilly = "Lexend";
  static const color = ThemeColors.textColor;
  static const headerColor = ThemeColors.grey;
  static const textSize = 16.0;
  static const h1TextSize = 28.0;
  static const h2TextSize = 24.0;
  static const h3TextSize = 20.0;
  static const h4TextSize = 18.0;
  static const h5TextSize = 16.0;
  static const smallTextSize = 10.0;
  static const buttonTextSize = 16.0;
  static TextTheme get textTheme => TextTheme(
        // displayLarge,
        displayLarge: style(fontSize: 15),
        displayMedium: style(fontSize: 15),
        displaySmall: style(fontSize: 15),
        // displaySmall,
        headlineLarge: style(fontSize: 40),
        headlineMedium: _h1,
        headlineSmall: _h2,
        titleLarge: _h3,

        /// 16
        titleMedium: _h5,
        // titleSmall,
        /// 18
        bodyLarge: style(fontSize: h4TextSize),

        /// 16
        bodyMedium: normal,

        /// 10
        bodySmall: small,
        // labelLarge,
        // labelMedium,
        // labelSmall,
        // headline1: _h1,
        // headline2: _h2,
        // headline3: _h3,
        // headline4: _h4,
        // headline5: _h5,
        // headline6: h6,
        // subtitle1,
        // subtitle2,
        // bodyText1,
        // bodyText2,
        // caption,
        // button,
        // overline,
      );

  static TextStyle get _h1 => title(fontSize: h1TextSize);
  static TextStyle get _h2 => title(fontSize: h2TextSize);
  static TextStyle get _h3 => title(fontSize: h3TextSize);
  static TextStyle get _h4 => title(fontSize: h4TextSize);
  static TextStyle get _h5 => title(fontSize: h5TextSize);
  static const normal = TextStyle(color: color, fontSize: textSize);
  static const small = TextStyle(color: color, fontSize: smallTextSize);

  static TextStyle style({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double? fontSize,
  }) =>
      TextStyle(
        color: color ?? ThemeFont.color,
        fontWeight: fontWeight,
        fontSize: fontSize ?? textSize,
      );

  static TextStyle header({
    Color? color,
    FontWeight fontWeight = FontWeight.bold,
    double? fontSize,
  }) =>
      style(
        color: color ?? ThemeFont.headerColor,
        fontWeight: fontWeight,
        fontSize: fontSize ?? textSize,
      );

  static TextStyle title({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double? fontSize,
  }) =>
      style(
        color: color ?? ThemeFont.color,
        fontWeight: fontWeight,
        fontSize: fontSize ?? textSize,
      );
}
