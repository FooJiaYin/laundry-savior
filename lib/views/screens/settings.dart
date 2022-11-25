import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../models/global_state.dart';
import '../../theme/theme.dart';
import '../components/app_bar.dart';
import '../components/default_payment_dialog.dart';
import '../components/reminder_config_dialog.dart';
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
    return ScaffoldPage(
      appBar: AppBar(
        title: CenterAppBar(title: S.of(context).settings),
        automaticallyImplyLeading: false,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("General", style: ThemeFont.header()),
          // Dormitory & Floor
          SettingItem(
            iconName: "home_outlined",
            title: "My Dormitory",
            value: (context.dormitory?.name ?? 'Unset') + (context.floor != null ? ", ${context.floor}F" : ""),
            onTap: () => showDialog(context: context, builder: (context) => const SelectDormDialog()),
          ),
          // Default Payment Method
          SettingItem(
            iconName: "money",
            title: "Default Payment Method",
            value: context.defaultPaymentMethod ?? "Not Set",
            onTap: () => showDialog(context: context, builder: (context) => const DefaultPaymentDialog()),
          ),
          // TODO: Change Language
          const SettingItem(iconName: "ball", title: "Language", value: "System"),
          const SizedBox(height: 24),
          // Reminder setting
          Text("Reminder", style: ThemeFont.header()),
          SettingItem(
            iconName: "bell_outlined",
            title: "Machine available",
            value: context.machineAvailable.summary,
            onTap: () => showDialog(
              context: context,
              builder: (context) => ReminderConfigDialog(
                title: "Machine Available",
                config: context.machineAvailable,
                onChanged: (value) => context.update(machineAvailable: value),
              ),
            ),
          ),
          SettingItem(
            iconName: "bell_outlined",
            title: "Laundry done",
            value: context.laundryDone.summary,
            onTap: () => showDialog(
              context: context,
              builder: (context) => ReminderConfigDialog(
                title: "Laundry Done",
                config: context.laundryDone,
                onChanged: (value) => context.update(laundryDone: value),
              ),
            ),
          ),
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
