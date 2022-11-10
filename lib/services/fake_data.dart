/// Global service, MUST call `init()` when app first launched!
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/account.dart';
import '../models/dormitory.dart';
import '../models/file.dart';
import '../models/machine.dart';
import '../models/sample.dart';
import '../models/user.dart';

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

  static Future signIn(Account account) async {
    authenticated.add(true);
  }

  static Future signOut() async {
    authenticated.add(false);
  }

  /// Example
  static Future<List<SampleData>> getData() async {
    var sample = SampleData(
      name: "First Item",
      description: "Hello World!",
      user: User(
          id: 123,
          name: "Alice",
          profileImage: File(url: "https://d1hjkbq40fs2x4.cloudfront.net/2016-07-16/files/cat-sample_1313.jpg"),
          email: "a@gmail.com",
          createdTime: DateTime.now(),
          lastActive: DateTime.now()),
      createdTime: DateTime.now(),
      tags: ["cats", "cute"],
    );
    return [
      sample,
      sample,
      sample,
      sample,
      sample,
      sample,
      sample,
      sample,
      sample,
      sample,
      sample,
      sample,
      sample,
      sample,
      sample,
    ];
  }

  static WashingMachine washingMachine = WashingMachine(
    id: 0,
    floor: 8,
    section: 'A',
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
    ];
  }

  static Future<List<Machine>> getDryerMachines(Dormitory dorm) async {
    return [
      dryerMachine,
      dryerMachine.copyWith(status: inUse),
      dryerMachine.copyWith(status: overdue),
    ];
  }

  static const dorm = Dormitory(
    id: 'ntu_male_1',
    name: "Male 1",
    imageUrl: "assets/images/dorm.png",
    university: "ntu",
    floors: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
  );

  static Future<Dormitory> getDormitory() async {
    return dorm;
  }

  static Future<List<Dormitory>> getDormitories(String university) async {
    return List<Dormitory>.generate(20, (i) => dorm);
  }
}
