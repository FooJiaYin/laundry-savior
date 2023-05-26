import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.text = "",
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.gradient,
    this.width,
    this.padding,
    this.disabled = false,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  final String text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final Gradient? gradient;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final bool disabled;
  final dynamic onPressed;
  final dynamic onLongPress;

  TextStyle buttonTextStyle() {
    var style = ThemeFont.style();
    if (borderColor != null) {
      style = style.merge(TextStyle(color: borderColor));
    } else if (disabled) {
      style = style.merge(const TextStyle(color: Colors.black54));
    }
    return style.merge(textStyle);
  }

  @override
  Widget build(BuildContext context) {
    var button = backgroundColor != null || borderColor == null
        ? ElevatedButton(
            onPressed: disabled ? null : onPressed,
            onLongPress: disabled ? onPressed : onLongPress,
            style: ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: padding ?? Dimensions.buttonPadding,
              minimumSize: width != null ? Size(width!, 0) : Size.zero,
              surfaceTintColor: backgroundColor ?? Colors.transparent,
              shadowColor: Colors.transparent,
              side: borderColor != null ? BorderSide(color: borderColor!) : null,
              primary: onPressed == null || disabled ? Theme.of(context).disabledColor : backgroundColor ?? (gradient != null ? Colors.transparent : null),
            ),
            child: Text(text, style: buttonTextStyle()),
          )
        : OutlinedButton(
            onPressed: disabled ? null : onPressed,
            onLongPress: disabled ? onPressed : onLongPress,
            style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding ?? Dimensions.buttonPadding),
              minimumSize: width != null ? MaterialStateProperty.all<Size>(Size(width!, 0)) : MaterialStateProperty.all<Size>(Size.zero),
              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
              side: MaterialStateProperty.all(BorderSide(color: borderColor!)),
              shape: borderRadius != null ? MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius!))) : null,
              // backgroundColor: onPressed == null || disabled
              //   ? MaterialStateProperty.all<Color>(Colors.grey)
              //   : MaterialStateProperty.all<Color>(backgroundColor!)
            ),
            child: Text(text, style: buttonTextStyle()),
          );
    return gradient != null
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? Dimensions.buttonRadius)),
              gradient: gradient,
            ),
            child: button,
          )
        : button;
  }
}

class RoundIconButton extends StatelessWidget {
  const RoundIconButton(
    this.icon, {
    Key? key,
    this.backgroundSize = Dimensions.iconButtonSize,
    this.backgroundColor = ThemeColors.backgroundColor,
    this.iconSize = Dimensions.iconSize,
    this.iconColor,
    this.borderRadius = 100,
    this.shadows = ThemeDecoration.neumorphicShadow,
    this.onTap,
  }) : super(key: key);
  final dynamic icon;
  final double backgroundSize;
  final Color backgroundColor;
  final double iconSize;
  final Color? iconColor;
  final double borderRadius;
  final List<BoxShadow>? shadows;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: backgroundSize,
        height: backgroundSize,
        margin: EdgeInsets.zero,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
          boxShadow: shadows,
        ),
        child: icon.runtimeType == IconData ? Icon(icon, size: iconSize, color: iconColor) : SizedBox(width: iconSize, height: iconSize, child: icon),
      ),
    );
  }
}
