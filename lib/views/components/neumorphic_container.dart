// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../widgets/container.dart';

class NeumorphicContainer extends CardContainer {
  const NeumorphicContainer({
    Key? key,
    required child,
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
    shadows: shadows ?? ThemeDecoration.neumorphicShadow,
    onTap: onTap,
    onLongPress: onLongPress,
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}