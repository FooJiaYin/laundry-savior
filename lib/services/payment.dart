import 'package:flutter/material.dart';
import '../models/global_state.dart';
import '../views/screens/machine.dart';

class Payment {
  static pay(context, {required String paymentMethod, required Machine machine}) {
    // TODO: Payment
      GlobalState.of(context, listen: false).update(currentMachine: machine, status: Status.mode);
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => MachinePage(machine),
        ),
      );
  }
}