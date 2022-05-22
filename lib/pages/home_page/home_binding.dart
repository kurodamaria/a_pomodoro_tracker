import 'package:a_pomodoro_tracler/db/db.dart';
import 'package:a_pomodoro_tracler/state/PomodoroConfiguration.dart';
import 'package:a_pomodoro_tracler/state/TaskListController.dart';
import 'package:a_pomodoro_tracler/state/TimerController.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(PomodoroDatabase());

    await InitRawConfiguration.init();

    final config = PomodoroConfiguration();
    Get.put(PomodoroConfiguration());
    Get.put(TimerController(config: config));
    Get.put(TaskListController());
    Get.put(FinishedTasksController());
  }
}
