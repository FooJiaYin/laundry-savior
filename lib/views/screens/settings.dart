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
        children: [],
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
