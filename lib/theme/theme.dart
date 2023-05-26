import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimensions.dart';
import 'font.dart';

export 'colors.dart';
export 'decoration.dart';
export 'dimensions.dart';
export 'font.dart';

class CustomTheme with ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  static ThemeData defaultTheme = ThemeData(
    useMaterial3: true,
    fontFamily: ThemeFont.fontFamily,

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
    backgroundColor: ThemeColors.backgroundColor,
    shadowColor: ThemeColors.grey,
    disabledColor: ThemeColors.lightGrey,
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
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
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
    appBarTheme: AppBarTheme(
      backgroundColor: ThemeColors.backgroundColor,
      foregroundColor: ThemeColors.grey,
      surfaceTintColor: ThemeColors.backgroundColor,
      titleTextStyle: ThemeFont.header(fontSize: 24),
      toolbarHeight: 64,
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
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: ThemeColors.backgroundColor,
      titleTextStyle: ThemeFont.header(fontSize: 20),
      contentTextStyle: ThemeFont.header(fontSize: 20),
    ),
    listTileTheme: const ListTileThemeData(
      textColor: ThemeColors.textColor,
      iconColor: ThemeColors.textColor,
    ),
    chipTheme: ChipThemeData(
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.buttonRadius)),
      padding: const EdgeInsets.symmetric(horizontal: 4),
    ),
    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: const BorderSide(color: ThemeColors.grey, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    )
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