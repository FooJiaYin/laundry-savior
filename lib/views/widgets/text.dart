// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

import '../../theme/font.dart';
import '../../utils/string.dart';

class ListItemText extends StatelessWidget {
  ListItemText({
    this.text = "",
    this.textStyle,
    this.bulletType = "•",
    this.bulletColor,
    Key? key,
  }) : super(key: key);

  final String text;
  final TextStyle? textStyle;
  final String bulletType;
  final Color? bulletColor;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: "•  ", style: bulletColor != null ? ThemeFont.style(color: bulletColor) : null),
          TextSpan(text: text, style: textStyle),
        ],
      ),
    );
  }
}

class CopyText extends StatelessWidget {
  final String text;
  late String? label;
  final String? buttonLabel;

  CopyText({Key? key, required this.text, this.label, this.buttonLabel}) : super(key: key) {
    label ??= text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectableText(label!),
        ElevatedButton(
          onPressed: text.copyToClipboard,
          child: Text(buttonLabel ?? S.of(context).copy),
        )
      ],
    );
  }
}
