import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.text = "",
    this.width,
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
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
  final double? width;
  final EdgeInsetsGeometry? padding;
  final bool disabled;
  final dynamic onPressed;
  final dynamic onLongPress;

  @override
  Widget build(BuildContext context) {
    return backgroundColor != null || borderColor == null
    ? ElevatedButton( 
      onPressed: onPressed, 
      onLongPress: disabled? onPressed : onLongPress, 
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding ?? Dimensions.buttonPadding),
          minimumSize: width != null ? MaterialStateProperty.all<Size>(Size(width!, 0)) : MaterialStateProperty.all<Size>(Size.zero),
          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          side: borderColor != null ? MaterialStateProperty.all(BorderSide(color: borderColor!)) : null,
          backgroundColor: onPressed == null || disabled 
            ? MaterialStateProperty.all<Color>(Theme.of(context).disabledColor)
            : backgroundColor != null
            ? MaterialStateProperty.all<Color>(backgroundColor!)
            : null,
        ),
      child: Text(text, style: textStyle ?? 
        (borderColor != null ? TextStyle(color: borderColor) : 
          disabled ? const TextStyle(color: Colors.black54): null),),
    ) 
    : OutlinedButton( 
      onPressed: disabled? null : onPressed, 
      onLongPress: disabled? null : onLongPress, 
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
      child: Text(text, style: TextStyle(color: borderColor).merge(textStyle)),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  const RoundIconButton(
    this.icon, {
    Key? key,
    this.backgroundSize = 44,
    this.backgroundColor = Colors.white,
    this.iconSize = Dimensions.iconSize,
    this.iconColor = ThemeColors.primaryColor,
    this.borderRadius = 100,
    this.shadows,
    this.onTap,
  }) : super(key: key);
  final dynamic icon;
  final double backgroundSize;
  final Color backgroundColor;
  final double iconSize;
  final Color iconColor;
  final double borderRadius;
  final List<BoxShadow>? shadows;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
        child: icon.runtimeType == IconData ? Icon(icon, size: iconSize, color: iconColor) : icon,
      ),
    );
  }
}
