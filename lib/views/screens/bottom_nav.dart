import 'package:flutter/material.dart';
import '../route.dart';
import '../widgets/nav_bar.dart';

class BottomTabNavigationPage extends StatefulWidget {
  const BottomTabNavigationPage({
    this.tab = TabItem.home,
    Key? key,
  }) : super(key: key);

  final TabItem tab;

  @override
  State<BottomTabNavigationPage> createState() => _BottomTabNavigationPageState();
}

class _BottomTabNavigationPageState extends State<BottomTabNavigationPage> {
  late int currentTabId;

  @override
  void initState() {
    currentTabId = TabItem.values.indexOf(widget.tab);
    super.initState();
  }

  onTabChanged(int value) => setState(() => currentTabId = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: IndexedStack(
        index: currentTabId,
        children: TabItem.tabs,
      ),
      bottomNavigationBar: NavBar(
        onTabChanged: onTabChanged,
      ),
    );
  }
}
