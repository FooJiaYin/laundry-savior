import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../widgets/button.dart';
import 'neumorphic_container.dart';

class NeumorphicNumberInput extends StatefulWidget {
  const NeumorphicNumberInput({
    Key? key,
    this.initialValue = 0,
    this.prefix = "",
    this.min,
    this.max,
    this.onChanged,
  }) : super(key: key);

  final int initialValue;
  final String prefix;
  final int? min;
  final int? max;
  final onChanged;

  @override
  State<NeumorphicNumberInput> createState() => _NeumorphicNumberInputState();
}

class _NeumorphicNumberInputState extends State<NeumorphicNumberInput> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.max == null || value < widget.max!
            ? RoundIconButton(
                Icons.add_rounded,
                onTap: () => setState(() {
                  value++;
                  widget.onChanged(value);
                }),
              )
            : const SizedBox(width: Dimensions.iconSize + 20),
        Expanded(
          child: NeumorphicContainer(
            margin: EdgeInsets.symmetric(horizontal: 12),
            pressed: true,
            padding: EdgeInsets.all(16.0),
            shadowRotation: 0,
            gradient: const LinearGradient(
              transform: GradientRotation(1.4),
              stops: [0.3, 0.5, 0.7],
              colors: [
                ThemeColors.grey30,
                ThemeColors.backgroundColor,
                Colors.white,
              ],
            ),
            child: Center(child: Text("$value${widget.prefix}")),
          ),
        ),
        widget.min == null || value > widget.min!
            ? RoundIconButton(Text("—", textAlign: TextAlign.center),
                onTap: () => setState(() {
                      value--;
                      widget.onChanged(value);
                    }))
            : const SizedBox(width: Dimensions.iconSize + 20),
      ],
    );
  }
}
