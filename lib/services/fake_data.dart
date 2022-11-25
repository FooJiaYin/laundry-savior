import 'dart:async';

import 'package:flutter/material.dart';

import '../models/dormitory.dart';
import '../models/global_state.dart';
import '../utils/string.dart';
import '../views/route.dart';
import 'notification.dart';

extension washingMachineSimulator on WashingMachine {
  int get phaseOffset => (12 - (id % 3) * 4 - floor + 1) % 12;
  MachineStatus updateStatus(int timePassed) {
    int time = (timePassed + phaseOffset) % 12;
    status = MachineStatus(
      code: time < 2
          ? StatusCode.available
          : time < 10
              ? StatusCode.in_use
              : StatusCode.overdue,
      durationEstimated: const Duration(minutes: 40),
      durationPassed: Duration(minutes: (time - 2) * 5),
    );
    return status;
  }
}

extension dryerMachineSimulator on DryerMachine {
  int get phaseOffset => (22 - (id % 2) * 4 + (floor - 1) * 7) % 22;
  MachineStatus updateStatus(int timePassed) {
    int time = (timePassed + phaseOffset) % 22;
    status = MachineStatus(
      code: time < 2
          ? StatusCode.available
          : time < 7
              ? StatusCode.in_use
              : time < 9
                  ? StatusCode.overdue
                  : time < 11
                      ? StatusCode.available
                      : time < 21
                          ? StatusCode.in_use
                          : StatusCode.overdue,
      durationEstimated: Duration(minutes: time < 11 ? 25 : 50),
      durationPassed: Duration(minutes: (time >= 11 ? time - 11 : time - 2) * 5),
    );
    return status;
  }
}

class FakeData {
  static int timer = 0;

  static void init() {
    var state = GlobalState.instance;
    Timer.periodic(const Duration(seconds: 2), (Timer t) {
      timer = (timer + 1) % 12;
      for (var machine in washingMachines) {
        if (machine != state.currentMachine || state.status == Status.waiting || state.status == Status.idle) washingMachineSimulator(machine).updateStatus(timer);
      }
      for (var machine in dryerMachines) {
        if (machine != state.currentMachine || state.status == Status.waiting || state.status == Status.idle) dryerMachineSimulator(machine).updateStatus(timer);
      }
      updateCurrentMachine(GlobalState.instance);
      GlobalState.instance.notifyListeners();
    });
  }

  static void updateCurrentMachine(GlobalState state) {
    if (state.status == Status.idle || state.status == Status.waiting) {
      if (state.currentMachine != null && state.currentMachine!.status.code != StatusCode.available) {
        if (state.status == Status.waiting) {
          NotificationService.showNotification(
            title: "You just missed it!",
            body: "${state.currentMachine!.type} on ${state.currentMachine!.floor}F is being used by other",
            details: NotificationService.machineAvailableNotificationDetails,
          );
        }
        state.currentMachine = null;
      }
      if (state.currentMachine == null || state.currentMachine!.floor != state.floor) {
        Machine? availableMachine;
        if (state.waitingMachine == WashingMachine) {
          availableMachine = washingMachines.nearestAvailable(state);
        } else {
          availableMachine = dryerMachines.nearestAvailable(state);
        }

        /// Update if no currentMachine or availableMachine is nearer
        if (availableMachine != null && (state.currentMachine == null || (availableMachine.floor - state.floor!).abs() < (state.currentMachine!.floor - state.floor!).abs())) {
          state.currentMachine = availableMachine;
          if (state.status == Status.waiting) {
            NotificationService.showNotification(
              title: "${state.currentMachine!.type} available",
              body: "Hurry up before it's used by other!",
              details: NotificationService.machineAvailableNotificationDetails,
            );
          }
        }
      }
    } else if (state.status == Status.using) {
      state.currentMachine!.status = state.currentMachine!.status.updateStatus(5);
      if (state.currentMachine!.status.code == StatusCode.overdue && state.currentMachine!.status.durationPassed < const Duration(minutes: 10)) {
        NotificationService.showNotification(
          title: "Laundry is done!",
          body: "on ${state.currentMachine!.locationString}, ${state.dormitory!.name}",
          details: NotificationService.laundryDoneNotificationDetails,
        );
      }
    }
  }

  static var washingMachines = List<WashingMachine>.generate(
    33,
    (i) => WashingMachine(
      id: i,
      floor: ((i + 1) / 3).ceil(),
      // section: 'A',
      status: const MachineStatus(code: StatusCode.available),
    )..updateStatus(0),
  );

  static var dryerMachines = List<DryerMachine>.generate(
    22,
    (i) => DryerMachine(
      id: i,
      floor: ((i + 1) / 2).ceil(),
      status: const MachineStatus(code: StatusCode.available),
    )..updateStatus(0),
  );

  static get machines => <Machine>[...washingMachines, ...dryerMachines];

  static Future<List<Machine>> getMachines(Dormitory dorm, Type? type) async {
    return type == null ? machines : machines.where((machine) => machine.type == type).toList();
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
    );
    state.update(status: Status.using);
  }

  static pay(context, {required String paymentMethod, required Machine machine}) {
    GlobalState.set(context, currentMachine: machine, status: Status.mode);
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => PaymentPage(machine: machine),
      ),
    );
  }
}
