import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'dormitory.dart';
import 'machine.dart';

enum Status { idle, waitingFloor, waitingAll, pay, mode, using }

class GlobalState with ChangeNotifier {
  Dormitory? dormitory;
  int? floor;
  Machine? currentMachine;
  Status status = Status.idle;
  String? defaultPaymentMethod;
  bool get anonymous => dormitory == null || floor == null;

  reset() {
    dormitory = null;
    floor = null;
    currentMachine = null;
    status = Status.idle;
    defaultPaymentMethod = null;
    notifyListeners();
  }

  update({
    Dormitory? dormitory,
    int? floor,
    Machine? currentMachine,
    Status? status,
    String? defaultPaymentMethod,
    GlobalState? state,
  }) {
    this.dormitory = dormitory ?? state?.dormitory ?? this.dormitory;
    this.floor = floor ?? state?.floor ?? this.floor;
    this.currentMachine = currentMachine ?? state?.currentMachine ?? this.currentMachine;
    this.status = status ?? state?.status ?? this.status;
    this.defaultPaymentMethod = defaultPaymentMethod ?? state?.defaultPaymentMethod ?? this.defaultPaymentMethod;
    notifyListeners();
  }

  static GlobalState of(context, {bool listen = true}) => Provider.of<GlobalState>(context, listen: listen);
}
