import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../widgets/button.dart';

class NeumorphicButton extends StatelessWidget {
  const NeumorphicButton({
    Key? key,
    required this.text,
    this.textColor,
    this.disabled = false,
    this.gradient,
    this.width = double.infinity,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final Color? textColor;
  final Gradient? gradient;
  final double? width;
  final bool disabled;
  final dynamic onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(Dimensions.buttonRadius)),
        gradient: gradient,
        boxShadow: ThemeDecoration.neumorphicShadow,
      ),
      child: Button(
        disabled: disabled,
        backgroundColor: gradient == null ? ThemeColors.backgroundColor : Colors.transparent,
        gradient: gradient,
        text: text,
        textStyle: TextStyle(
          color: textColor ?? (disabled ? ThemeColors.grey : gradient != null ? Colors.white : ThemeColors.darkGrey),
        ),
        width: width,
        onPressed: onPressed,
      ),
    );
  }

  static confirm({bool disabled = false, onPressed}) {
    return NeumorphicButton(
      text: "Confirm",
      disabled: disabled,
      gradient: ThemeColors.blueRingGradient,
      onPressed: onPressed,
    );
  }
}
