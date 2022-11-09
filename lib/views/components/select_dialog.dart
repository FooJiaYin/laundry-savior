import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../widgets/container.dart';
import 'app_bar.dart';

class SelectDialog extends StatelessWidget {
  const SelectDialog({
    Key? key,
    this.title,
    this.child,
    this.padding = Dimensions.dialogContainerPadding,
    this.children = const <Widget>[],
  }) : super(key: key);

  final String? title;
  final Widget? child;
  final EdgeInsets padding;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: Dimensions.dialogInsetPadding,
      child: CardContainer(
        padding: padding,
        child: Column(
          children: [
            // Fix title height so that ListView below can expand
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.dialogContainerPadding.left - padding.left),
              child: CenterAppBar(title: title, titleStyle: ThemeFont.header(fontSize: 20)),
            ),
            const SizedBox(height: 16),
            if (child != null) Expanded(child: child!),
            ...children,
          ],
        ),
      ),
    );
  }
}
