// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/theme.dart';

class SelectChip extends StatelessWidget {
  SelectChip({
    Key? key,
    required this.label,
    this.icon,
    this.isSelected = false,
    this.onSelected,
  }) : super(key: key);
  final String label;
  final icon;
  bool isSelected;
  final onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon(Icons.notifications_outlined, size: 12),
          if (icon.runtimeType == String)
            SvgPicture.asset(
              "assets/icons/$icon.svg", width: 16, height: 16,
              // SvgPicture.asset("assets/icons/bell_${subscribedFloors.contains(floor)? 'filled': 'outlined'}.svg", width: 16, height: 16,
              color: isSelected ? Colors.white : ThemeColors.textColor,
            ),
          if (icon.runtimeType == IconData)
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : ThemeColors.textColor
            ),
          Text(label)
        ],
      ),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : ThemeColors.textColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: ThemeColors.lightGrey,
      selectedColor: ThemeColors.primaryColor,
      selected: isSelected,
      showCheckmark: false,
      onSelected: onSelected,
    );
  }
}
