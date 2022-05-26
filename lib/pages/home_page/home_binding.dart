import 'package:a_pomodoro_tracler/db/db.dart';
import 'package:a_pomodoro_tracler/state/PomodoroConfiguration.dart';
import 'package:a_pomodoro_tracler/state/PomodoroStats.dart';
import 'package:a_pomodoro_tracler/state/TaskListController.dart';
import 'package:a_pomodoro_tracler/state/TimerController.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  // Don't write async code in this function.
  void dependencies() {
    Get.put(PomodoroDatabase());
    final config = PomodoroConfiguration();
    final tc = TimerController(config: config);
    Get.put<TimerController>(tc);
    Get.put(PomodoroConfiguration());
    Get.put(PomodoroStats());
    Get.put(FinishedTasksController());
    final tlc = TaskListController();
    Get.put(tlc);

    ever(tc.status, (value) {
      if (value == TimerControllerStatus.finished) {
        tlc.finishTopOne();
        FlutterRingtonePlayer.playNotification();
        Get.snackbar('Timer has finished', 'wowowowoowow!😁🙌');
      }
    });
  }
}
