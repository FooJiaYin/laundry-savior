import 'dart:async';

import 'package:flutter/material.dart';

import '../models/dormitory.dart';
import '../models/global_state.dart';
import '../services/machine.dart';
import '../utils/string.dart';
import 'notification.dart';

extension WashingMachineSimulator on WashingMachine {
  /// Scale = 5 min
  int get phaseOffset => (12 - (id % 3) * 4 - floor + 1) % 12;

  /// timePassed : scale = 1 min
  simulateStatus(int timePassed) {
    var timeStep = (timePassed + phaseOffset * 5) % (12 * 5);

    status = MachineStatus(
      code: timeStep < 2 * 5
          ? StatusCode.available
          : timeStep < 10 * 5
              ? StatusCode.in_use
              : StatusCode.overdue,
      durationEstimated: const Duration(minutes: 40),
      durationPassed: Duration(minutes: timeStep - 2 * 5),
    );

    notifyListeners();
  }
}

extension DryerMachineSimulator on DryerMachine {
  /// Scale = 5 min
  int get phaseOffset => (22 - (id % 2) * 4 + (floor - 1) * 7) % 22;

  /// timePassed : scale = 1 min
  simulateStatus(int timePassed) {
    var timeStep = (timePassed + phaseOffset * 5) % (22 * 5);

    status = MachineStatus(
      code: timeStep < 2 * 5
          ? StatusCode.available
          : timeStep < 7 * 5
              ? StatusCode.in_use
              : timeStep < 9 * 5
                  ? StatusCode.overdue
                  : timeStep < 11 * 5
                      ? StatusCode.available
                      : timeStep < 21 * 5
                          ? StatusCode.in_use
                          : StatusCode.overdue,
      durationEstimated: Duration(minutes: timeStep < 11 * 5 ? 25 : 50),
      durationPassed: Duration(minutes: (timeStep >= 11 * 5 ? timeStep - 11 * 5 : timeStep - 2 * 5)),
    );

    notifyListeners();
  }
}

class FakeData {
  static int noFloors = 11;
  static int washingMachinesPerFloor = 3;
  static int dryerMachinesPerFloor = 2;

  static var washingMachines = List<WashingMachine>.generate(
    noFloors * washingMachinesPerFloor,
    (i) => WashingMachine(
      id: i,
      floor: ((i + 1) / 3).ceil(),
      // section: 'A',
      status: const MachineStatus(code: StatusCode.available),
    )..simulateStatus(0),
  );

  static var dryerMachines = List<DryerMachine>.generate(
    noFloors * dryerMachinesPerFloor,
    (i) => DryerMachine(
      id: i + noFloors * washingMachinesPerFloor,
      floor: ((i + 1) / 2).ceil(),
      status: const MachineStatus(code: StatusCode.available),
    )..simulateStatus(0),
  );

  static get machines => <Machine>[...washingMachines, ...dryerMachines];

  static void updateMachinesPeriodically() {
    var state = GlobalState.instance;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      var time = timer.tick % (132 * 5);

      for (var machine in machines) {
        // Except currentMachine if it's in use
        if (machine != state.currentMachine || state.status == Status.idle || state.status == Status.waiting) {
          if (machine.type == WashingMachine) {
            WashingMachineSimulator(machine).simulateStatus(time);
          } else {
            DryerMachineSimulator(machine).simulateStatus(time);
          }
        }
      }

      updateCurrentMachine(GlobalState.instance);
      GlobalState.instance.notifyListeners();
    });
  }

  static void updateCurrentMachine(GlobalState state) {
    if (state.status == Status.idle || state.status == Status.waiting) {
      // currentMachine is used by other
      if (state.currentMachine != null && state.currentMachine!.status.code != StatusCode.available) {
        if (state.status == Status.waiting) NotificationService.machineMissed(state.currentMachine!);
        state.currentMachine = null;
      }
      // Find new machine if no currentMachine set or it's on other floor
      if (state.currentMachine == null || state.currentMachine!.floor != state.floor) {
        Machine? availableMachine;
        if (state.waitingMachine == WashingMachine) {
          availableMachine = washingMachines.nearestAvailable(state);
        } else {
          availableMachine = dryerMachines.nearestAvailable(state);
        }

        // Update currentMachine if no currentMachine or found a nearer machine
        if (availableMachine != null && (state.currentMachine == null || (availableMachine.floor - state.floor!).abs() < (state.currentMachine!.floor - state.floor!).abs())) {
          state.currentMachine = availableMachine;
          if (state.status == Status.waiting) NotificationService.machineAvailable(state.currentMachine!);
        }
      }
    }

    /// Update current machine status
    else if (state.status == Status.using) {
      state.currentMachine!..updateStatus()..notifyListeners();
      if (state.currentMachine!.status.code == StatusCode.overdue && state.currentMachine!.status.durationPassed < Duration(minutes: 2)) {
        NotificationService.laundryDone(state.currentMachine!, state.dormitory!);
      }
    }
  }

  static Future<List<Machine>> getMachines(Dormitory dorm, Type? type) async {
    return type == null ? machines : machines.where((machine) => machine.type == type).toList();
  }

  static Dormitory getDormitoryById(String id) => Dormitory(
        id: id,
        name: id.replaceAll("_", " ").capitalizeEach,
        imageUrl: "assets/images/ntu_$id.png",
        university: "ntu",
        floors: List.generate(noFloors, (i) => i+1),
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

  static wash(context, {String mode = "Normal"}) {
    var state = GlobalState.of(context, listen: false);
    state.currentMachine!.use();
    state.update(status: Status.using);
    Navigator.pushNamedAndRemoveUntil(context, '/current_machine', (route) => route.isFirst);
  }

  static pay(context, {required String paymentMethod, int minutes = 40, required Machine machine}) {
    machine.status = machine.status.copyWith(durationEstimated: Duration(minutes: minutes));
    GlobalState.set(context, status: Status.pay, currentMachine: machine);
    Navigator.pushNamed(context, "/pay");
  }

  static takeOutClothes(GlobalState state) {
    state.currentMachine!.done();
    if (state.currentMachine?.type == DryerMachine) {
      state.waitingMachine = WashingMachine;
    } else {
      state.waitingMachine = DryerMachine;
    }
    state.update(status: Status.idle, currentMachine: null);
    updateCurrentMachine(state);
  }
}
