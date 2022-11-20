// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'neumorphic_container.dart';

class NeumorphicToggle extends StatefulWidget {
  const NeumorphicToggle({
    Key? key,
    this.initialIndex = 0,
    this.selectedIndex,
    this.height = 48,
    this.radius,
    this.gradient,
    required this.optionWidgets,
    this.onChanged,
  }) : super(key: key);

  final double height;
  final int initialIndex;
  final int? selectedIndex;
  final double? radius;
  final Gradient? gradient;
  final List<Widget> optionWidgets;
  final ValueChanged<int>? onChanged;

  @override
  State<NeumorphicToggle> createState() => _NeumorphicToggleState();
}

class _NeumorphicToggleState extends State<NeumorphicToggle> {
  int _selectedIndex = 0;
  Duration animationDuration = const Duration(milliseconds: 200);
  int get selectedIndex => widget.selectedIndex ?? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex ?? widget.initialIndex;
  }

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
          _selectedIndex = (_selectedIndex + 1) % widget.optionWidgets.length;
        });
        widget.onChanged?.call(_selectedIndex);
      },
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: SizedBox(
          height: widget.height,
          child: Stack(
            children: [
              NeumorphicContainer(
                pressed: true,
                shadowRotation: 1.4,
                borderRadius: widget.radius ?? Dimensions.cardRadius,
                gradient: const LinearGradient(
                  transform: GradientRotation(1.4),
                  stops: [0.3, 0.5, 0.7],
                  colors: [
                    ThemeColors.grey30,
                    ThemeColors.backgroundColor,
                    Colors.white,
                  ],
                ),
                child: const SizedBox.expand(),
              ),
              AnimatedAlign(
                alignment: _alignment(selectedIndex),
                duration: animationDuration,
                child: FractionallySizedBox(
                  widthFactor: 1 / widget.optionWidgets.length,
                  heightFactor: 1,
                  child: NeumorphicContainer(
                    borderRadius: widget.radius ?? Dimensions.cardRadius,
                    gradient: widget.gradient,
                    // shadows: ThemeDecoration.circleShadow,
                    child: const SizedBox.expand(),
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
                              color: selectedIndex == e.key
                                  ? widget.gradient != null
                                      ? Colors.white
                                      : ThemeColors.primaryColor
                                  : ThemeColors.grey,
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
