import 'package:flutter/material.dart';

import '../../models/global_state.dart';
import '../../services/payment.dart';
import '../../theme/theme.dart';
import '../screens/machine.dart';
import 'payment_method.dart';
import 'select_dialog.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog(
    this.data, {
    this.price = 10,
    Key? key,
  }) : super(key: key);

  final Machine data;
  final int price;

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  bool setAsDefault = false;

  @override
  Widget build(BuildContext context) {
    selectMode(String name) {
      if (setAsDefault) {
        GlobalState.set(context, defaultPaymentMethod: name);
      }
      Payment.pay(context, machine: widget.data, paymentMethod: name);
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
                  text: "NT ",
                  style: ThemeFont.header(fontSize: 24, color: ThemeColors.darkGrey),
                  children: [
                    TextSpan(
                      text: widget.price.toString(),
                      style: TextStyle(fontSize: 48),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text("Select Payment Method", style: ThemeFont.header()),
          const SizedBox(height: 12),
          ...paymentMethods(onSelect: selectMode),
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
