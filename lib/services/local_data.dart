import 'dart:async';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/global_state.dart';

class LocalData {
  static Future<GlobalState> loadGlobalState() async {
    var state = GlobalState.instance;
    final sharedPreferences = await SharedPreferences.getInstance();
    final config = sharedPreferences.getString('config');
    if (config != null) state.fromJson(config);

    // Write to local storage when GlobalState updates
    state.addListener(() {
      sharedPreferences.setString('config', state.toJson());
    });
    FlutterNativeSplash.remove();
    return state;
  }
}