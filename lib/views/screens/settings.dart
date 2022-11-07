import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../theme/theme.dart';
import '../components/setting_item.dart';
import '../widgets/button.dart';
import '../widgets/scaffold_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBar: AppBar(
        title: _titleRow(),
        automaticallyImplyLeading: false,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("General", style: ThemeFont.header()),
          const SettingItem(iconName: "home_outlined", title: "My Dormitory", value: "Guo-Ching, 8f"),
          const SettingItem(iconName: "money", title: "Default Payment Method", value: "Not Set"),
          const SettingItem(iconName: "ball", title: "Language", value: "System"),
          const SizedBox(height: 24),
          Text("Reminder", style: ThemeFont.header()),
          const SettingItem(iconName: "drop_outlined", title: "Machine Available", value: "notification\n30m before"),
          const SettingItem(iconName: "wind", title: "Laundry done", value: "notification\n30m before"),
          const SizedBox(height: 24),
          Text("Other", style: ThemeFont.header()),
          const SettingItem(iconName: "question", title: "FAQ"),
          const SettingItem(iconName: "mail", title: "Feedback"),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _titleRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RoundIconButton(
            Icons.keyboard_arrow_left_rounded,
            backgroundSize: 40,
            iconColor: ThemeColors.grey,
            backgroundColor: ThemeColors.backgroundColor,
            shadows: ThemeDecoration.neumorphicShadow,
            onTap: () => Navigator.pop(context),
          ),
          Text(S.of(context).settings),
          const SizedBox(width: 40),
        ],
      );
}
