import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'neumorphic_container.dart';

class PriceButton extends StatelessWidget {
  const PriceButton({
    Key? key,
    required this.price,
    this.name,
    this.isSelected = false,
    this.onPressed,
  }) : super(key: key);

  final int price;
  final String? name;
  final bool isSelected;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NeumorphicContainer(
          width: 64.0,
          height: 64.0,
          // pressed: !isSelected,
          // shadowRotation: 1,
          gradient: isSelected ? ThemeColors.greenRingGradient : null,
          shadows: isSelected ? [...ThemeDecoration.circleShadow, ...ThemeDecoration.neumorphicShadow] : ThemeDecoration.neumorphicShadow,
          onTap: () => onPressed(price),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("NT", style: ThemeFont.header(fontSize: 12, color: isSelected ? Colors.white: null)),
                Text(price.toString(), style: ThemeFont.header(fontSize: 24, color: isSelected ? Colors.white: null)),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        if (name != null) Text(name!, style: ThemeFont.small)
      ],
    );
  }
}