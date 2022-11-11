import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/global_state.dart';

class LocalData {
  static Future<GlobalState> loadGlobalState() async {
    var state = GlobalState();
    final sharedPreferences = await SharedPreferences.getInstance();
    final config = sharedPreferences.getString('config');
    if (config != null) state.fromJson(config);

    // Write to local storage when GlobalState updates
    state.addListener(() {
      sharedPreferences.setString('config', state.toJson());
    });
    return state;
  }
}