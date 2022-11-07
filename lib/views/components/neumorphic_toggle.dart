import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'neumorphic_container.dart';

class NeumorphicToggle extends StatefulWidget {
  const NeumorphicToggle({
    Key? key,
    required this.optionWidgets,
    this.height = 48,
    // this.selectedIndex = 0,
    this.onChanged,
  }) : super(key: key);

  final double height;
  // final int selectedIndex;
  final List<Widget> optionWidgets;
  final ValueChanged<int>? onChanged;

  @override
  State<NeumorphicToggle> createState() => _NeumorphicToggleState();
}

class _NeumorphicToggleState extends State<NeumorphicToggle> {
  int selectedIndex = 0;
  Duration animationDuration = const Duration(milliseconds: 400);

  Alignment _alignment(int idx) {
    var percentX = selectedIndex / (widget.optionWidgets.length - 1);
    var aligmentX = -1.0 + (2.0 * percentX);
    return Alignment(aligmentX, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = (selectedIndex + 1) % widget.optionWidgets.length;
        });
        widget.onChanged?.call(selectedIndex);
      },
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: SizedBox(
          height: widget.height,
          child: Stack(
            children: [
              const NeumorphicContainer(
                pressed: true,
                shadowRotation: 1.4,
                gradient: LinearGradient(
                  transform: GradientRotation(1.4),
                  stops: [0.3, 0.5, 0.7],
                  colors: [
                    ThemeColors.grey30,
                    ThemeColors.backgroundColor,
                    Colors.white,
                  ],
                ),
                child: SizedBox.expand(),
              ),
              AnimatedAlign(
                alignment: _alignment(selectedIndex),
                duration: animationDuration,
                child: FractionallySizedBox(
                  widthFactor: 1 / widget.optionWidgets.length,
                  heightFactor: 1,
                  child: const NeumorphicContainer(
                    gradient: ThemeColors.blueLinearGradient,
                    child: SizedBox.expand(),
                  ),
                ),
              ),
              SizedBox(
                height: widget.height,
                child: Row(
                  children: widget.optionWidgets
                      .asMap()
                      .entries
                      .map(
                        (e) => Expanded(
                          child: AnimatedDefaultTextStyle(
                            duration: animationDuration,
                            style: ThemeFont.title(
                              color: selectedIndex == e.key ? Colors.white : ThemeColors.grey,
                              // fontWeight: selectedIndex == e.key ? FontWeight.bold : FontWeight.normal,
                            ),
                            child: e.value,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
