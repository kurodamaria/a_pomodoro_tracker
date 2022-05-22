import 'package:a_pomodoro_tracler/db/db.dart';
import 'package:a_pomodoro_tracler/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(PomodoroDatabase());
  runApp(const HomePage());
}
