import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dormitory.dart';
import '../models/global_state.dart';
import '../views/screens/machine.dart';

class FakeData {
  static Future<GlobalState> loadGlobalState() async {
    var state = GlobalState();
    final sharedPreferences = await SharedPreferences.getInstance();
    final config = sharedPreferences.getString('config');
    if (config != null) state.fromJson(config);
    state.addListener(() {
      sharedPreferences.setString('config', state.toJson());
    });
    return state;
  }

  static WashingMachine washingMachine = WashingMachine(
    id: 0,
    floor: 8,
    // section: 'A',
    status: MachineStatus(code: StatusCode.available),
  );

  static DryerMachine dryerMachine = DryerMachine(
    id: 0,
    floor: 8,
    section: 'A',
    status: MachineStatus(code: StatusCode.available),
  );

  static const inUse = MachineStatus(
    code: StatusCode.in_use,
    durationEstimated: Duration(minutes: 40),
    durationPassed: Duration(minutes: 13),
  );

  static const overdue = MachineStatus(
    code: StatusCode.overdue,
    durationEstimated: Duration(minutes: 40),
    durationPassed: Duration(minutes: 10),
  );

  static Future<List<Machine>> getWashingMachines(Dormitory dorm) async {
    return [
      washingMachine,
      washingMachine.copyWith(status: inUse),
      washingMachine.copyWith(status: inUse),
      washingMachine.copyWith(status: overdue),
      washingMachine.copyWith(status: overdue),
    ];
  }

  static Future<List<Machine>> getDryerMachines(Dormitory dorm) async {
    return [
      dryerMachine,
      dryerMachine.copyWith(status: inUse),
      dryerMachine.copyWith(status: overdue),
    ];
  }

  static const dorm1 = Dormitory(
    id: 'ntu_male_1',
    name: "Male 1",
    imageUrl: "assets/images/dorm.png",
    university: "ntu",
    floors: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
  );

  static const dorm2 = Dormitory(
    id: 'ntu_male_2',
    name: "Male 2",
    imageUrl: "assets/images/dorm.png",
    university: "ntu",
    floors: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
  );

  static Future<Dormitory> getDormitory() async {
    return dorm1;
  }

  static Future<List<Dormitory>> getDormitories(String university) async {
    return [
      ...List<Dormitory>.generate(10, (i) => dorm1),
      ...List<Dormitory>.generate(10, (i) => dorm2),
    ];
  }

  static setReminder(context) async {
    var state = GlobalState.of(context);
    if (state.status == Status.waitingAll || state.status == Status.waitingFloor)
    Future.delayed(const Duration(seconds: 10), () {
      state.update(currentMachine: FakeData.washingMachine);
    });
  }

  static wash() {}

  static pay(context, {required String paymentMethod, required Machine machine}) {
    // TODO: Payment
    GlobalState.set(context, currentMachine: machine, status: Status.mode);
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => MachinePage(machine),
      ),
    );
  }
}
