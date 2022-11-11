import 'package:flutter/material.dart';

import '../../models/global_state.dart';
import '../../theme/theme.dart';
import 'neumorphic_button.dart';
import 'payment_method.dart';
import 'select_dialog.dart';

class DefaultPaymentDialog extends StatelessWidget {
  const DefaultPaymentDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    selectMode(String? name) {
      GlobalState.set(context, defaultPaymentMethod: name);
      Navigator.pop(context);
    }

    return SelectDialog(
      title: "Payment Method",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Default Payment Method",
            style: ThemeFont.header(),
          ),
          const SizedBox(height: 12),
          ...paymentMethods(onSelect: selectMode),
          const Expanded(
            child: Center(
              child: Text(
                "Set up shortcut for your\nfavourite payment method. \nYou can change it here anytime.",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          NeumorphicButton(text: "Clear", textColor: ThemeColors.coral, onPressed: () => selectMode(null)),
        ],
      ),
    );
  }
}
