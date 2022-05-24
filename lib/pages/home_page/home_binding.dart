import 'package:a_pomodoro_tracler/db/db.dart';
import 'package:a_pomodoro_tracler/state/PomodoroConfiguration.dart';
import 'package:a_pomodoro_tracler/state/PomodoroStats.dart';
import 'package:a_pomodoro_tracler/state/TaskListController.dart';
import 'package:a_pomodoro_tracler/state/TimerController.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(PomodoroDatabase());
    Get.put(await SharedPreferences.getInstance());
    await InitRawConfiguration.init();
    final config = PomodoroConfiguration();
    final tc = TimerController(config: config);
    Get.put(tc);
    Get.put(PomodoroConfiguration());
    Get.put(PomodoroStats());
    Get.put(FinishedTasksController());
    final tlc = TaskListController();
    Get.put(tlc);

    ever(tc.status, (value) => {
      if (value == TimerControllerStatus.finished) {
        tlc.finishTopOne()
      }
    });
  }
}
