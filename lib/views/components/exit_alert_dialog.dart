import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'neumorphic_button.dart';

class ExitAlertDialog extends StatelessWidget {
  /// AlertDialog with 'Exit' and 'Cancel' Button
  const ExitAlertDialog({
    Key? key,
    this.title = "Are you sure to exit?",
    this.description = "",
  }) : super(key: key);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description, style: ThemeFont.style()),
      actions: <Widget>[
        NeumorphicButton(text: "Exit", textColor: ThemeColors.coral, width: 50, onPressed: () => Navigator.of(context).pop(true)),
        NeumorphicButton(text: "Cancel", width: 50, onPressed: () => Navigator.of(context).pop(false)),
      ],
    );
  }
}
