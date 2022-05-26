import 'package:a_pomodoro_tracler/db/db.dart';
import 'package:a_pomodoro_tracler/state/PomodoroConfiguration.dart';
import 'package:a_pomodoro_tracler/state/PomodoroStats.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final timeFormat = DateFormat.Hms();
final minuteFormat = DateFormat.Hm();

/// Evaluate finish time for each task in [tasks]
/// based on the current pomodoro configuration.
List<DateTime> evaluateFinishTime(List<Task> tasks) {
  PomodoroStats stats = Get.find<PomodoroStats>();
  PomodoroConfiguration config = Get.find<PomodoroConfiguration>();

  int finishedPomodoroCounts = stats.finishedPomodoroCount;
  List<DateTime> dates = [DateTime.now()];
  for (Task task in tasks) {
    int remPomodoroToLongBreak =
        config.cycleLength - finishedPomodoroCounts % config.cycleLength;
    int trimmed = task.totalPomodoro - remPomodoroToLongBreak;
    int longBreaksCount =
        trimmed ~/ config.cycleLength + (trimmed >= 0 ? 1 : 0);
    int shortBreaksCount = task.totalPomodoro - longBreaksCount;
    Get.log('$remPomodoroToLongBreak $trimmed ${trimmed~/config.cycleLength} $longBreaksCount $shortBreaksCount');
    dates.add(dates.last.add(Duration(
        minutes: task.totalPomodoro * config.pomodoroLength +
            longBreaksCount * config.longBreakLength +
            shortBreaksCount * config.shortBreakLength)));
    finishedPomodoroCounts += task.totalPomodoro;
  }
  return dates.sublist(1);
}

String minuteString(Duration duration) {
  int minutes = duration.inMinutes;
  int seconds = duration.inSeconds - minutes * 60;
  return '${minutes < 10 ? '0' : ''}$minutes:${seconds < 10 ? '0' : ''}$seconds';
}
