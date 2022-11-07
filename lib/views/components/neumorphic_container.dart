// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../widgets/container.dart';

class NeumorphicContainer extends CardContainer {
  const NeumorphicContainer({
    Key? key,
    required child,
    this.pressed = false,
    this.shadowRotation = 0,
    width = double.infinity,
    height,
    backgroundColor = ThemeColors.backgroundColor,
    borderColor,
    borderRadius = Dimensions.cardRadius,
    padding = EdgeInsets.zero,
    margin = EdgeInsets.zero,
    gradient,
    shadows,
    onTap,
    onLongPress,
  }) : super(
    child: child,
    width: width,
    height: height,
    backgroundColor: backgroundColor,
    borderColor: borderColor,
    borderRadius: borderRadius,
    padding: padding,
    margin: margin,
    gradient: gradient,
    shadows: shadows ?? (pressed ? ThemeDecoration.neumorphicShadowPressed : ThemeDecoration.neumorphicShadow),
    onTap: onTap,
    onLongPress: onLongPress,
    key: key,
  );

  final bool pressed;
  final double shadowRotation;

  Widget pressedContainer() => Stack(
      children: [
        CardContainer(
          margin: margin,
          padding: padding,
          gradient: gradient ?? LinearGradient(
            transform: GradientRotation(shadowRotation),
            colors: [
              ThemeColors.grey.withOpacity(0.2),
              backgroundColor,
              Colors.white.withOpacity(1),
            ],
          ),
          child: child,
        ),
        CardContainer(
          margin: margin,
          padding: padding,
          backgroundColor: Colors.transparent,
          shadows: shadows,
          child: child,
        )
      ],
    );

  @override
  Widget build(BuildContext context) {
    return pressed?  pressedContainer() : super.build(context);
  }
}