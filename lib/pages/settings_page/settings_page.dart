import 'package:a_pomodoro_tracler/state/PomodoroConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = Get.find<PomodoroConfiguration>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pomodoro Length', style: Get.textTheme.titleLarge),
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Obx(() {
                    return Text('Current Value: ${config.pomodoroLength} min',
                        style: Get.textTheme.subtitle1);
                  }),
                  TextField(
                    decoration:
                        InputDecoration(labelText: 'New value (in minutes)'),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    onSubmitted: (input) {
                      config.pomodoroLength = int.parse(input);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
