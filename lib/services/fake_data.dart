import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dormitory.dart';
import '../models/global_state.dart';
import '../utils/string.dart';
import '../views/screens/machine.dart';

class FakeData {
  static WashingMachine washingMachine = WashingMachine(
    id: 0,
    floor: 8,
    // section: 'A',
    status: const MachineStatus(code: StatusCode.available),
  );

  static DryerMachine dryerMachine = DryerMachine(
    id: 0,
    floor: 8,
    section: 'A',
    status: const MachineStatus(code: StatusCode.available),
  );

  static const inUse = MachineStatus(
    code: StatusCode.in_use,
    durationEstimated: Duration(minutes: 40),
    durationPassed: Duration(minutes: 13),
  );

  static const overdue = MachineStatus(
    code: StatusCode.overdue,
    durationEstimated: Duration(minutes: 40),
    durationPassed: Duration(minutes: 5),
  );

  static Future<List<Machine>> getMachines(Dormitory dorm, Type? type) async {
    var machines = [
      washingMachine,
      washingMachine.copyWith(status: inUse),
      washingMachine.copyWith(floor: 7),
      washingMachine.copyWith(floor: 4),
      washingMachine.copyWith(status: overdue),
      washingMachine.copyWith(status: overdue),
      dryerMachine,
      dryerMachine.copyWith(status: inUse),
      dryerMachine.copyWith(status: overdue),
    ];
    return type == null? machines : machines.where((machine) => machine.type == type).toList();
  }

  static Dormitory getDormitoryById(String id) => Dormitory(
        id: id,
        name: id.replaceAll("_", " ").capitalizeEach,
        imageUrl: "assets/images/ntu_$id.png",
        university: "ntu",
        floors: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
      );

  static Future<List<Dormitory>> getDormitories(String university) async {
    return [
      "female_1",
      "female_2",
      "female_3",
      "female_4",
      "female_5",
      "female_6",
      "female_7",
      "female_8",
      "male_1",
      "male_2",
      "male_3",
      "male_4",
      "male_5",
      "male_6",
      "male_7",
      "male_8",
      "freshman_female",
      "graduate_male_1",
      "graduate_female_1",
      "guo_ching",
    ].map(getDormitoryById).toList();
  }

  static wash(GlobalState state) {
    // var state = context.watch<GlobalState>();
    state.currentMachine!.status = const MachineStatus(
      code: StatusCode.in_use,
      durationEstimated: Duration(minutes: 40),
      durationPassed: Duration.zero,
    );
    state.update(status: Status.using);
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) => {
        if (state.currentMachine!.status.code == StatusCode.available)
          {timer.cancel()}
        else
          {
            state.currentMachine!.status = state.currentMachine!.status.updateStatus(5),
            state.update()
            // GlobalState.set(context),
          }
      },
    );
  }

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
