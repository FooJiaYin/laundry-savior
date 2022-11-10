import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../models/global_state.dart';
import '../../theme/theme.dart';
import '../components/app_bar.dart';
import '../components/default_payment_dialog.dart';
import '../components/select_dorm_dialog.dart';
import '../components/setting_item.dart';
import '../widgets/scaffold_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    var state = GlobalState.of(context);
    return ScaffoldPage(
      appBar: AppBar(
        title: CenterAppBar(title: S.of(context).settings),
        automaticallyImplyLeading: false,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("General", style: ThemeFont.header()),
          SettingItem(
            iconName: "home_outlined",
            title: "My Dormitory",
            value: (state.dormitory?.name ?? 'Unset') + (state.floor != null ? ", ${state.floor}F" : ""),
            onTap: () => showDialog(context: context, builder: (context) => SelectDormDialog()),
          ),
          // Default Payment Method
          SettingItem(
            iconName: "money",
            title: "Default Payment Method",
            value: state.defaultPaymentMethod ?? "Not Set",
            onTap: () => showDialog(context: context, builder: (context) => DefaultPaymentDialog()),
          ),
          // TODO: Change Language
          const SettingItem(iconName: "ball", title: "Language", value: "System"),
          const SizedBox(height: 24),
          // TODO: Change reminder setting
          Text("Reminder", style: ThemeFont.header()),
          const SettingItem(iconName: "drop_outlined", title: "Machine Available", value: "notification\n30m before"),
          const SettingItem(iconName: "wind", title: "Laundry done", value: "notification\n30m before"),
          const SizedBox(height: 24),
          // TODO: FAQ & Feedback
          Text("Other", style: ThemeFont.header()),
          const SettingItem(iconName: "question", title: "FAQ"),
          const SettingItem(iconName: "mail", title: "Feedback"),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
