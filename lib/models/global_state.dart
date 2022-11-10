import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'dormitory.dart';
import 'machine.dart';
import 'reminder_config.dart';

enum Status { idle, waitingFloor, waitingAll, pay, mode, using }

class GlobalState with ChangeNotifier {
  Dormitory? dormitory;
  int? floor;
  Machine? currentMachine;
  Status status = Status.idle;
  Type? waitingMachine = WashingMachine;
  String? defaultPaymentMethod;
  ReminderConfig machineAvailable = ReminderConfig.defaultConfig;
  ReminderConfig laundryDone = ReminderConfig.defaultConfig;
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
    dormitory = "",
    floor = "",
    currentMachine = "",
    status,
    defaultPaymentMethod = "",
    machineAvailable,
    laundryDone
  }) {
    this.dormitory = dormitory != "" ? dormitory : this.dormitory;
    this.floor = floor != "" ? floor : this.floor;
    this.currentMachine = currentMachine != "" ? currentMachine : this.currentMachine;
    this.status = status ?? this.status;
    this.defaultPaymentMethod = defaultPaymentMethod != "" ? defaultPaymentMethod : this.defaultPaymentMethod;
    this.machineAvailable = machineAvailable ?? this.machineAvailable;
    this.laundryDone = laundryDone ?? this.laundryDone;
    notifyListeners();
  }

  static GlobalState of(context, {bool listen = true}) => Provider.of<GlobalState>(context, listen: listen);
}
