// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../widgets/button.dart';

class CenterAppBar extends StatelessWidget {
  const CenterAppBar({
    Key? key,
    this.title = "",
    this.titleStyle,
    this.leftIcon = const NeumorphicBackButton(),
    this.rightIcon = const SizedBox(width: 40),
  }) : super(key: key);

  final String? title;
  final TextStyle? titleStyle;
  final Widget? leftIcon;
  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (leftIcon != null) leftIcon!,
            if (title != null)
              Flexible(
                child: Text(
                  title!,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            if (rightIcon != null) rightIcon!,
          ],
        ),
      ),
    );
  }
}

class NeumorphicBackButton extends StatelessWidget {
  const NeumorphicBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundIconButton(
      backgroundColor: Theme.of(context).backgroundColor,
      Icons.keyboard_arrow_left_rounded,
      onTap: () => Navigator.pop(context),
    );
  }
}
