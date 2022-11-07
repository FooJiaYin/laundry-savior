import 'package:flutter/material.dart';
import 'colors.dart';
import 'font.dart';

export 'colors.dart';
export 'font.dart';

class CustomTheme with ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  static ThemeData defaultTheme = ThemeData(
    useMaterial3: true,
    fontFamily: ThemeFont.fontFamilly,

    /// Colors
    primaryColor: ThemeColors.primaryColor,
    // colorSchemeSeed: ThemeColors.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ThemeColors.primaryColor,
      primary: ThemeColors.primaryColor,
    ),
    primaryColorDark: ThemeColors.primaryDark,
    primaryColorLight: ThemeColors.primaryLight,
    scaffoldBackgroundColor: ThemeColors.backgroundColor,
    backgroundColor: Colors.grey.shade400,
    shadowColor: Colors.grey.withOpacity(0.2),
    disabledColor: Colors.grey,

    textTheme: ThemeFont.textTheme,

    buttonTheme: ButtonThemeData(
      // 4
      padding: Dimensions.buttonPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.buttonRadius),
      ),
      // disabledColor: _theme.disabledColor,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(Dimensions.buttonPadding),
        shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
        backgroundColor: MaterialStateProperty.all<Color>(ThemeColors.primaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),

    iconTheme: const IconThemeData(
      color: ThemeColors.textColor,
      size: 20,
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(ThemeColors.primaryColor),
      ),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColors.backgroundColor,
      foregroundColor: ThemeColors.textColor,
    ),

    navigationBarTheme: const NavigationBarThemeData(
      indicatorColor: ThemeColors.primaryColor,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: ThemeColors.primaryColor,
      unselectedItemColor: ThemeColors.textColor,
      selectedLabelStyle: TextStyle(fontSize: 12),
      showUnselectedLabels: true,
    ),

    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.cardRadius),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData.dark();

  // static ThemeData onPrimaryTheme(context) => Theme.of(context).copyWith(
  //       brightness: Brightness.dark,
  //       textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
  //       iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
  //       appBarTheme: const AppBarTheme(
  //         backgroundColor: Colors.transparent,
  //         foregroundColor: Colors.white,
  //         centerTitle: true,
  //       ),
  //       inputDecorationTheme: const InputDecorationTheme(
  //         iconColor: Colors.white,
  //         prefixIconColor: Colors.white,
  //         suffixIconColor: Colors.white,
  //         enabledBorder: UnderlineInputBorder(
  //           borderSide: BorderSide(color: Colors.white30),
  //         ),
  //         focusedBorder: UnderlineInputBorder(
  //           borderSide: BorderSide(color: Colors.white),
  //         ),
  //         hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white24),
  //       ),
  //       checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
  //             side: MaterialStateBorderSide.resolveWith(
  //               (states) => BorderSide(width: 2.0, color: states.contains(MaterialState.selected) ? ThemeColors.primaryColor : Colors.white),
  //             ),
  //           ),
  //     );
}

class Dimensions {
  /// 24
  static const screenPadding = 24.0;

  /// 48
  static const screenPaddingWide = 48.0;

  /// 12
  static const containerPadding = 12.0;

  /// 12
  static const cardRadius = 12.0;

  /// 20
  static const iconSize = 20.0;

  /// 50
  static const buttonRadius = 50.0;

  /// 12
  static const itemMargin = 12.0;

  /// 36, 10
  static EdgeInsetsGeometry buttonPadding = const EdgeInsets.symmetric(
    horizontal: 36.0,
    vertical: 10.0,
  );
}

class ThemeDecoration {
  static List<BoxShadow> shadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 1,
      blurRadius: 5,
      offset: const Offset(0, 4), // changes position of shadow
    ),
  ]; // changes position of shadow
}

/* ThemeData(
    useMaterial3: true,

    /// Colors
    primaryColor, colorSchemeSeed, colorScheme
    scaffoldBackgroundColor, backgroundColor, disabledColor
    splashColor, shadowColor, errorColor, hintColor

    /// Component color
    cardColor, dividerColor, indicatorColor, dialogBackgroundColor

    /// Components
    textTheme, fontFamily, textSelectionTheme
    iconTheme, primaryIconTheme
    buttonTheme, buttonBarTheme, elevatedButtonTheme, textButtonTheme, outlinedButtonTheme, toggleButtonsTheme, floatingActionButtonTheme
    appBarTheme, navigationBarTheme, bottomAppBarTheme, bottomNavigationBarTheme, tabBarTheme, drawerTheme
    dataTableTheme
    cardTheme, scrollbarTheme, listTileTheme, expansionTileTheme, dividerTheme, chipTheme, bannerTheme
    inputDecorationTheme, checkboxTheme, radioTheme, switchTheme, sliderTheme
    dialogTheme, bottomSheetTheme, popupMenuTheme, snackBarTheme, tooltipTheme, timePickerTheme
    progressIndicatorTheme

    /// Animation
    // pageTransitionsTheme
  ); */