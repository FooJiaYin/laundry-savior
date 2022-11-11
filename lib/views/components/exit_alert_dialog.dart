import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'neumorphic_button.dart';

class ExitAlertDialog extends StatelessWidget {
  const ExitAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure to exit?'),
      content: Text("You have paid for the machine!", style: ThemeFont.style()),
      actions: <Widget>[
        NeumorphicButton(text: "Exit", textColor: ThemeColors.coral, width: 50, onPressed: () => Navigator.of(context).pop(true)),
        NeumorphicButton(text: "Cancel", width: 50, onPressed: () => Navigator.of(context).pop(false)),
      ],
    );
  }
}
