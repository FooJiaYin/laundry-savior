import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../services/local_data.dart';
import 'dormitory.dart';
import 'machine.dart';
import 'reminder_config.dart';

enum Status { idle, waitingFloor, waitingAll, pay, mode, using }

class GlobalState with ChangeNotifier {
  Dormitory? dormitory;
  Machine? currentMachine;
  int? floor;
  Status status = Status.idle;
  Type? waitingMachine = WashingMachine;
  String? defaultPaymentMethod;
  ReminderConfig machineAvailable = ReminderConfig.defaultConfig;
  ReminderConfig laundryDone = ReminderConfig.defaultConfig;
  bool get anonymous => dormitory == null || floor == null;
  static get init => LocalData.loadGlobalState;

  reset() {
    dormitory = null;
    floor = null;
    status = Status.idle;
    currentMachine = null;
    waitingMachine = WashingMachine;
    defaultPaymentMethod = null;
    notifyListeners();
  }

  update({
    dormitory = "",
    floor = "",
    status,
    currentMachine = "",
    waitingMachine,
    defaultPaymentMethod = "",
    machineAvailable,
    laundryDone,
  }) {
    this.dormitory = dormitory != "" ? dormitory : this.dormitory;
    this.floor = floor != "" ? floor : this.floor;
    this.status = status ?? this.status;
    this.currentMachine = currentMachine != "" ? currentMachine : this.currentMachine;
    this.waitingMachine = waitingMachine ?? this.waitingMachine;
    this.defaultPaymentMethod = defaultPaymentMethod != "" ? defaultPaymentMethod : this.defaultPaymentMethod;
    this.machineAvailable = machineAvailable ?? this.machineAvailable;
    this.laundryDone = laundryDone ?? this.laundryDone;
    notifyListeners();
  }

  static GlobalState of(context, {bool listen = true}) => Provider.of<GlobalState>(context, listen: listen);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dormitory': dormitory?.toMap(),
      'currentMachine': currentMachine?.toMap(),
      'floor': floor,
      'status': status.name,
      'waitingMachine': waitingMachine?.toString(),
      'defaultPaymentMethod': defaultPaymentMethod,
      'machineAvailable': machineAvailable.toMap(),
      'laundryDone': laundryDone.toMap(),
    };
  }

  fromMap(Map<String, dynamic> map) {
    update(
      dormitory: map['dormitory'] != null ? Dormitory.fromMap(map['dormitory'] as Map<String,dynamic>) : null,
      currentMachine: map['currentMachine'] != null ? Machine.fromMap(map['currentMachine'] as Map<String,dynamic>) : null,
      floor: map['floor'] != null ? map['floor'] as int : null,
      status: Status.values.byName(map['status'] as String),
      waitingMachine: map['waitingMachine'] != null && map['waitingMachine'] == "DryerMachine" ? DryerMachine : WashingMachine,
      defaultPaymentMethod: map['defaultPaymentMethod'] != null ? map['defaultPaymentMethod'] as String : null,
      machineAvailable: ReminderConfig.fromMap(map['machineAvailable'] as Map<String,dynamic>),
      laundryDone: ReminderConfig.fromMap(map['laundryDone'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);
}
