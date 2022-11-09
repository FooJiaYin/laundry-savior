// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'screens/bottom_nav.dart';
import 'screens/home.dart';
import 'screens/list.dart';
import 'screens/machine.dart';
import 'screens/settings.dart';
import 'screens/sign_in.dart';
import 'screens/sign_up.dart';

export 'screens/bottom_nav.dart';
export 'screens/home.dart';
export 'screens/list.dart';
export 'screens/settings.dart';
export 'screens/sign_in.dart';
export 'screens/sign_up.dart';
export 'screens/welcome.dart';

class AppRoute {
  static route(BuildContext context) => <String, WidgetBuilder>{
        "/sign_in": (context) => SignInPage(),
        "/sign_up": (context) => const SignUpPage(),
        "/home": (context) => BottomTabNavigationPage(tab: TabItem.home),
        "/settings": (context) => SettingPage(),
      };
}

enum TabItem {
  home(icon: Icons.home, label: "Home", tab: HomePage()),
  list(icon: Icons.list, label: "List", tab: ListPage()),
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
