import 'package:flutter/material.dart';

import '../../models/global_state.dart';
import '../../theme/theme.dart';
import '../screens/machine.dart';
import 'option_item.dart';
import 'select_dialog.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog(
    this.data, {
    Key? key,
  }) : super(key: key);

  final Machine data;

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  bool setAsDefault = false;

  @override
  Widget build(BuildContext context) {
    selectMode(String name) {
      if (setAsDefault) {
        GlobalState.of(context, listen: false).update(defaultPaymentMethod: name);
      }
      // TODO: Payment
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => MachinePage(widget.data),
        ),
      );
    }

    return SelectDialog(
      title: "Pay for",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: "NTD ",
                  style: ThemeFont.header(fontSize: 24, color: ThemeColors.darkGrey),
                  children: const [
                    TextSpan(
                      text: "10",
                      style: TextStyle(fontSize: 48),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text("Select Payment Method", style: ThemeFont.header()),
          const SizedBox(height: 12),
          PaymentMethod(name: "Line Pay", onTap: selectMode),
          PaymentMethod(name: "Apple Pay", onTap: selectMode),
          PaymentMethod(name: "JKO Pay", onTap: selectMode),
          PaymentMethod(name: "Credit Card", onTap: selectMode),
          const SizedBox(height: 8),
          Row(
            children: [
              // TODO: Neumorphic style checkbox
              Checkbox(
                value: setAsDefault,
                onChanged: (value) {
                  setState(() {
                    setAsDefault = value ?? setAsDefault;
                  });
                },
              ),
              const Text("Set as default"),
            ],
          )
        ],
      ),
    );
  }
}

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({
    Key? key,
    required this.name,
    this.onTap,
  }) : super(key: key);

  final String name;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return OptionItem(
      onTap: () => onTap(name),
      child: Text(name),
    );
  }
}
