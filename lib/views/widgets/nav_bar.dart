import 'package:flutter/material.dart';
import '../route.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key, this.onTabChanged}) : super(key: key);

  final Function(int)? onTabChanged;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentTabId = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: TabItem.values
          .map(
            (e) => NavigationDestination(
              icon: Icon(e.icon, color: e.index == _currentTabId ? Colors.white : null),
              label: e.label,
            ),
          )
          .toList(),
      selectedIndex: _currentTabId,
      onDestinationSelected: (value) {
        setState(() {
          _currentTabId = value;
        });
        widget.onTabChanged?.call(value);
      },
    );
  }
}