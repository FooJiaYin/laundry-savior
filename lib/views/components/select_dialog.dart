import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../widgets/container.dart';
import 'app_bar.dart';

class SelectDialog extends StatelessWidget {
  const SelectDialog({
    Key? key,
    this.title,
    this.child,
    this.children = const <Widget>[],
  }) : super(key: key);

  final String? title;
  final Widget? child;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: Dimensions.dialogInsetPadding,
      child: CardContainer(
        padding: Dimensions.dialogContainerPadding,
        child: Column(
          children: [
            CenterAppBar(title: title, titleStyle: ThemeFont.header(fontSize: 20)),
            const SizedBox(height: 32),
            if (child != null) child!,
            ...children,
          ],
        ),
      ),
    );
  }
}
