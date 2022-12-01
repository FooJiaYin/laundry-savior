import 'package:flutter/material.dart';

import 'neumorphic_container.dart';

class OptionItem extends StatelessWidget {
  const OptionItem({
    Key? key,
    this.height,
    this.padding = const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 8),
    this.verticalMargin = 8,
    required this.child,
    this.onTap,
  }) : super(key: key);

  final double? height;
  final EdgeInsets? padding;
  final double verticalMargin;
  final Widget child;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      height: height,
      padding: padding,
      margin: EdgeInsets.symmetric(vertical: verticalMargin),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: child,
          ),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_right),
        ],
      ),
    );
  }
}
