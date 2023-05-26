import 'package:flutter/material.dart';

import '../../models/global_state.dart';
import '../../services/fake_data.dart';
import '../../theme/theme.dart';
import '../screens/machine.dart';
import 'neumorphic_button.dart';
import 'payment_method.dart';
import 'select_dialog.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog(
    this.data, {
    this.price = 10,
    this.minutes = 40,
    Key? key,
  }) : super(key: key);

  final Machine data;
  final int price;
  final int minutes;

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  bool setAsDefault = false;
  String? selectedMethod;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedMethod = GlobalState.instance.defaultPaymentMethod;
      setAsDefault = GlobalState.instance.defaultPaymentMethod == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    pay() {
      if (setAsDefault) {
        GlobalState.set(context, defaultPaymentMethod: selectedMethod);
      }
      FakeData.pay(context, machine: widget.data, minutes: widget.minutes, paymentMethod: selectedMethod!);
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
                      style: const TextStyle(fontSize: 48),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text("Select Payment Method", style: ThemeFont.header()),
          const SizedBox(height: 12),
          ...paymentMethods(
            selectedMethod: selectedMethod,
            onSelect: (value) => setState(() {
              selectedMethod = value;
            }),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
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
          ),
          NeumorphicButton.confirm(disabled: selectedMethod == null, onPressed: pay),
        ],
      ),
    );
  }
}
