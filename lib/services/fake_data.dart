/// Global service, MUST call `init()` when app first launched!
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/dormitory.dart';
import '../models/machine.dart';

class FakeData {
  static final authenticated = StreamController<bool>.broadcast();

  static Future init() async {
    // onListen就要馬上廣播登入狀態，否則會視為未登入
    authenticated.onListen = () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      authenticated.add(true);
    };
  }

  /// 驗證是否為登入狀態
  static Stream<bool> isAuthenticated() {
    return authenticated.stream;
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
}
