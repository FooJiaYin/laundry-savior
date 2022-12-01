import 'package:flutter/material.dart';

import '../models/global_state.dart';
import 'screens/home.dart';
import 'screens/machine.dart';
import 'screens/payment.dart';
import 'screens/settings.dart';

export 'screens/bottom_nav.dart';
export 'screens/home.dart';
export 'screens/machine.dart';
export 'screens/payment.dart';
export 'screens/settings.dart';

class AppRoute {
  static route(BuildContext context) => <String, WidgetBuilder>{
        "/home": (context) => const HomePage(),
        "/settings": (context) => const SettingPage(),
        "/pay": (context) => const PaymentPage(),
        "/current_machine": (context) => MachinePage(GlobalState.instance.currentMachine),
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
