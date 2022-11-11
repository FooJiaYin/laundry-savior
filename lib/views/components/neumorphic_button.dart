// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../widgets/button.dart';

class NeumorphicButton extends StatelessWidget {
  const NeumorphicButton({
    Key? key,
    required this.text,
    this.textColor,
    this.gradient,
    this.width = double.infinity,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final Color? textColor;
  final Gradient? gradient;
  final double? width;
  final dynamic onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.buttonRadius)),
        gradient: gradient,
        boxShadow: ThemeDecoration.neumorphicShadow,
      ),
      child: Button(
        backgroundColor: gradient == null ? ThemeColors.backgroundColor : Colors.transparent,
        gradient: gradient,
        text: text,
        textStyle: TextStyle(
          color: textColor ?? (gradient != null ? Colors.white : ThemeColors.darkGrey),
        ),
        width: width,
        onPressed: onPressed,
      ),
    );
  }
}
