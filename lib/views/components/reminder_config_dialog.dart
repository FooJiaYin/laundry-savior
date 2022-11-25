import 'package:flutter/material.dart';

import '../../models/reminder_config.dart';
import '../../theme/theme.dart';
import 'neumorphic_button.dart';
import 'neumorphic_number_input.dart';
import 'neumorphic_toggle.dart';
import 'select_dialog.dart';

class ReminderConfigDialog extends StatefulWidget {
  const ReminderConfigDialog({
    Key? key,
    required this.config,
    required this.title,
    this.onChanged,
  }) : super(key: key);

  final ReminderConfig config;
  final String title;
  final onChanged;

  @override
  State<ReminderConfigDialog> createState() => _ReminderConfigDialogState();
}

class _ReminderConfigDialogState extends State<ReminderConfigDialog> {
  List<String> get methodOptions => ReminderConfig.methodOptions;
  
  late ReminderConfig _config;

  @override
  void initState() {
    super.initState();
    _config = widget.config.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    return SelectDialog(
      title: widget.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Text("Select Remind Method", style: ThemeFont.header()),
          const SizedBox(height: 16),
          NeumorphicToggle(
            optionWidgets: methodOptions.map((option) => Text(option, textAlign: TextAlign.center)).toList(),
            initialIndex: methodOptions.indexOf(_config.remindMethod),
            onChanged: (id) => _config.remindMethod = methodOptions[id],
          ),
          const SizedBox(height: 48),
          Text("Notify Me Before", style: ThemeFont.header()),
          const SizedBox(height: 16),
          NeumorphicNumberInput(
            initialValue: _config.remindBefore,
            prefix: " minutes",
            min: 0,
            onChanged: (value) => _config.remindBefore = value,
          ),
          const Expanded(child: SizedBox(height: 42)),
          NeumorphicButton(
            text: "Confirm",
            textColor: ThemeColors.primaryColor,
            onPressed: () => {
              widget.onChanged(_config),
              Navigator.of(context).pop(),
            },
          ),
          const SizedBox(height: 20),
          NeumorphicButton(
            text: "Cancel",
            textColor: ThemeColors.coral,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
