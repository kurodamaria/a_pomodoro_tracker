import 'package:a_pomodoro_tracler/app.dart';
import 'package:a_pomodoro_tracler/state/PomodoroConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(await SharedPreferences.getInstance());
  await InitRawConfiguration.init();
  runApp(const App());
}
