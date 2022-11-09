import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/global_state.dart';
import '../../theme/theme.dart';
import 'neumorphic_container.dart';
import 'select_dorm_dialog.dart';

class InstructionCard extends StatelessWidget {
  const InstructionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: leading icon
    var state = GlobalState.of(context);
    return _instructionCard(
      title: state.anonymous ? "Welcome to Laundry Savior" : "Hello",
      description: 'Tell us where do you live!',
      actionWidget: const ActionText('Select Dorm', color: ThemeColors.royalBlue),
      onTap: () => showDialog(context: context, builder: (context) => const SelectDormDialog()),
    );
  }

  Widget _instructionCard({required String title, required String description, Widget? leading, Widget? actionWidget, dynamic onTap}) {
    return NeumorphicContainer(
      padding: const EdgeInsets.only(top: 22, left: 22, bottom: 18, right: 12),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: ThemeFont.title()),
          Text(description, style: ThemeFont.style(fontSize: 12)),
          const SizedBox(height: 20),
          if (actionWidget != null) actionWidget,
        ],
      ),
    );
  }
}

class ActionText extends StatelessWidget {
  const ActionText(
    this.text, {
    Key? key,
    this.color = ThemeColors.primaryColor,
    this.icon = Icons.keyboard_arrow_right,
    this.alignment = MainAxisAlignment.end,
  }) : super(key: key);

  final String text;
  final Color color;
  final IconData icon;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: ThemeFont.header(color: color, fontSize: 16),
        ),
        Icon(icon, color: color, size: 24)
      ],
    );
  }
}
