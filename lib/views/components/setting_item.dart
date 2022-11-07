// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/theme.dart';
import '../../utils/string.dart';
import 'neumorphic_container.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    Key? key,
    required this.iconName,
    required this.title,
    this.value,
    this.onTap,
  }) : super(key: key);

  final String iconName;
  final String title;
  final dynamic value;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      height: 64.0,
      padding: const EdgeInsets.only(left: 14, right: 8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                SvgPicture.asset("assets/icons/$iconName.svg", width: 24, height: 24),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    title.capitalizeEach,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    style: ThemeFont.title(),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              Text(value?.toString().capitalizeFirst ?? ""),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ],
      ),
    );
  }
}
