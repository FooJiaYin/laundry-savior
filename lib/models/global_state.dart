import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../services/local_data.dart';
import 'dormitory.dart';
import 'machine.dart';
import 'reminder_config.dart';

export 'package:provider/provider.dart';

enum Status { idle, waiting, pay, mode, using }

class GlobalState with ChangeNotifier {
  static GlobalState instance = GlobalState();

  Dormitory? dormitory;
  Machine? currentMachine;
  int? floor;
  int viewIndex = 0; // 0 -> floor only, 1 -> All floors
  Status status = Status.idle;
  Type? waitingMachine = WashingMachine;
  Set<int> subscribedFloors = {};
  String? defaultPaymentMethod;
  ReminderConfig machineAvailable = ReminderConfig.defaultConfig;
  ReminderConfig laundryDone = ReminderConfig.defaultConfig;
  bool get anonymous => dormitory == null || floor == null;
  String? get subscribedFloorsString => "${(subscribedFloors.toList()..sort((a, b) => (a - b))).join(',')}F";
  static get init => LocalData.loadGlobalState;

  reset() {
    dormitory = null;
    floor = null;
    status = Status.idle;
    currentMachine = null;
    waitingMachine = WashingMachine;
    subscribedFloors = {};
    defaultPaymentMethod = null;
    notifyListeners();
  }

  update({
    dormitory = "",
    floor = "",
    status,
    viewIndex,
    currentMachine = "",
    waitingMachine,
    subscribedFloors,
    defaultPaymentMethod = "",
    machineAvailable,
    laundryDone,
  }) {
    this.dormitory = dormitory != "" ? dormitory : this.dormitory;
    this.floor = floor != "" ? floor : this.floor;
    this.status = status ?? this.status;
    this.viewIndex = viewIndex ?? this.viewIndex;
    this.currentMachine = currentMachine != "" ? currentMachine : this.currentMachine;
    this.waitingMachine = waitingMachine ?? this.waitingMachine;
    this.subscribedFloors = subscribedFloors ?? (floor != "" ? <int>{floor!} : this.subscribedFloors);
    this.defaultPaymentMethod = defaultPaymentMethod != "" ? defaultPaymentMethod : this.defaultPaymentMethod;
    this.machineAvailable = machineAvailable ?? this.machineAvailable;
    this.laundryDone = laundryDone ?? this.laundryDone;
    notifyListeners();
  }

  static GlobalState of(context, {bool listen = true}) => Provider.of<GlobalState>(context, listen: listen);
  static set(
    context, {
    dormitory = "",
    floor = "",
    currentMachine = "",
    subscribedFloors,
    viewIndex,
    status,
    defaultPaymentMethod = "",
    machineAvailable,
    laundryDone,
  }) {
    Provider.of<GlobalState>(context, listen: false).update(
      dormitory: dormitory,
      floor: floor,
      currentMachine: currentMachine,
      subscribedFloors: subscribedFloors,
      status: status,
      viewIndex: viewIndex,
      defaultPaymentMethod: defaultPaymentMethod,
      machineAvailable: machineAvailable,
      laundryDone: laundryDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dormitory': dormitory?.toMap(),
      // 'currentMachine': currentMachine?.toMap(),
      'floor': floor,
      // 'status': status.name,
      // 'waitingMachine': waitingMachine?.toString(),
      'subscribedFloors': subscribedFloors.toList(),
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
      status: map['status'] != null ? Status.values.byName(map['status'] as String) : null,
      waitingMachine: map['waitingMachine'] != null && map['waitingMachine'] == "DryerMachine" ? DryerMachine : WashingMachine,
      subscribedFloors: map['subscribedFloors'] != null ? List<int>.from(map['subscribedFloors'].cast<int>()).toSet() : {},
      defaultPaymentMethod: map['defaultPaymentMethod'] != null ? map['defaultPaymentMethod'] as String : null,
      machineAvailable: ReminderConfig.fromMap(map['machineAvailable'] as Map<String,dynamic>),
      laundryDone: ReminderConfig.fromMap(map['laundryDone'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);
}

extension GetState on BuildContext {
  state({bool listen = true}) {
    Provider.of<GlobalState>(this, listen: listen);
  }

  Dormitory? get dormitory => select<GlobalState, Dormitory?>((state) => state.dormitory);
  Machine? get currentMachine => select<GlobalState, Machine?>((state) => state.currentMachine);
  int? get floor => select<GlobalState, int?>((state) => state.floor);
  int get viewIndex => select<GlobalState, int>((state) => state.viewIndex);
  Status get status => select<GlobalState, Status>((state) => state.status);
  Type? get waitingMachine => select<GlobalState, Type?>((state) => state.waitingMachine);
  Set<int> get subscribedFloors => select<GlobalState, Set<int>>((state) => state.subscribedFloors);
  String? get defaultPaymentMethod => select<GlobalState, String?>((state) => state.defaultPaymentMethod);
  ReminderConfig get machineAvailable => select<GlobalState, ReminderConfig>((state) => state.machineAvailable);
  ReminderConfig get laundryDone => select<GlobalState, ReminderConfig>((state) => state.laundryDone);
  bool get anonymous => select<GlobalState, bool>((state) => state.anonymous);
  String? get subscribedFloorsString => select<GlobalState, String?>((state) => state.subscribedFloorsString);

  get update => Provider.of<GlobalState>(this, listen: false).update;
}
