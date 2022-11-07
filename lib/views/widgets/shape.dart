// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  const Circle({
    Key? key,
    this.size,
    this.width,
    this.height,
    this.color,
    this.borderColor,
    this.borderWidth,
    this.shadows,
    this.child,
  }) : super(key: key);

  final double? size;
  final double? width;
  final double? height;
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;
  final List<BoxShadow>? shadows;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 0,
        ),
        boxShadow: shadows,
      ),
      width: width ?? size,
      height: height ?? size,
      child: child,
    );
  }
}
