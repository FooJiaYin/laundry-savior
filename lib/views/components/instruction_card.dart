import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'neumorphic_container.dart';

class InstructionCard extends StatelessWidget {
  const InstructionCard({
    Key? key,
    required this.title,
    required this.description,
    this.leading,
    this.actionWidget,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String description;
  final Widget? leading;
  final Widget? actionWidget;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    // TODO: leading icon
    return NeumorphicContainer(
      padding: const EdgeInsets.only(top: 22, left: 22, bottom: 18, right: 12),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: ThemeFont.title()),
          Text(description, style: ThemeFont.style(fontSize: 12)),
          const SizedBox(height: 20),
          if (actionWidget != null) actionWidget!,
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
