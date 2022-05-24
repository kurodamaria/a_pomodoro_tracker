import 'package:a_pomodoro_tracler/pages/home_page/home_binding.dart';
import 'package:a_pomodoro_tracler/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: HomeBinding(),
      home: const HomePage(),
    );
  }
}
