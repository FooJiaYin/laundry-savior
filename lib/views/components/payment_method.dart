import 'package:flutter/material.dart';

import '../../models/global_state.dart';
import '../../theme/theme.dart';
import 'option_item.dart';

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
    var isDefault = name == context.select<GlobalState, String>((state) => state.defaultPaymentMethod ?? '');
    return OptionItem(
      onTap: () => onTap(name),
      child: Text(
        name,
        style: isDefault
            ? const TextStyle(
                fontWeight: FontWeight.bold,
                color: ThemeColors.primaryColor,
              )
            : null,
      ),
    );
  }
}

List<Widget> paymentMethods({Function(String)? onSelect}) => [
      PaymentMethod(name: "Line Pay", onTap: onSelect),
      PaymentMethod(name: "Apple Pay", onTap: onSelect),
      PaymentMethod(name: "JKO Pay", onTap: onSelect),
      PaymentMethod(name: "Credit Card", onTap: onSelect),
    ];
