import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    Key? key,
    required this.child,
    this.width = double.infinity,
    this.height,
    this.backgroundColor = Colors.white,
    this.borderColor,
    this.borderRadius = Dimensions.cardRadius,
    this.padding = const EdgeInsets.all(Dimensions.containerPadding),
    this.margin = const EdgeInsets.only(bottom: Dimensions.itemMargin),
    this.shadows,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);
  final Widget? child;
  final double width;
  final double? height;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final List<BoxShadow>? shadows;
  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: borderColor != null ? Border.all(color: borderColor!, width: 2.0) : null,
          boxShadow: shadows,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
