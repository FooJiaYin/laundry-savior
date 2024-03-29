import 'package:flutter/material.dart';
import 'dart:io';

import '../../models/global_state.dart';
import '../../theme/theme.dart';
import 'option_item.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod(
    this.name, {
    Key? key,
    this.selectedMethod,
    this.onTap,
  }) : super(key: key);

  final String name;
  final dynamic onTap;
  final String? selectedMethod;

  @override
  Widget build(BuildContext context) {
    var isDefault = name == (selectedMethod ?? context.defaultPaymentMethod);
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

List<Widget> paymentMethods({Function(String)? onSelect, String? selectedMethod}) => [
      PaymentMethod("Line Pay", onTap: onSelect, selectedMethod: selectedMethod),
      if (Platform.isIOS) PaymentMethod("Apple Pay", onTap: onSelect, selectedMethod: selectedMethod),
      PaymentMethod("JKO Pay", onTap: onSelect, selectedMethod: selectedMethod),
      PaymentMethod("Credit Card", onTap: onSelect, selectedMethod: selectedMethod),
    ];
