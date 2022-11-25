// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/settings.dart';

export 'screens/bottom_nav.dart';
export 'screens/home.dart';
export 'screens/machine.dart';
export 'screens/payment.dart';
export 'screens/settings.dart';
export 'screens/welcome.dart';

class AppRoute {
  static route(BuildContext context) => <String, WidgetBuilder>{
        "/home": (context) => HomePage(),
        "/settings": (context) => SettingPage(),
      };
}

enum TabItem {
  home(icon: Icons.home, label: "Home", tab: HomePage()),
  settings(icon: Icons.settings, label: "Settings", tab: SettingPage());

  final IconData icon;
  final String label;
  final Widget tab;

  const TabItem({
    required this.icon,
    required this.label,
    required this.tab,
  });

  static List<Widget> get tabs => values.map((e) => e.tab).toList();
}
