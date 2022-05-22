import 'package:a_pomodoro_tracler/db/db.dart';
import 'package:drift/drift.dart';
import 'package:get/get.dart';

/// Represent the init configuration when the program starts.
class InitRawConfiguration {
  static int pomodoroLength = 25;
  static int cycleLength = 4;
  static int shortBreakLength = 5;
  static int longBreakLength = 15;

  static Future<void> init() async {
    final db = Get.find<PomodoroDatabase>();
    final Preference rawPLength = await (db.preferences.select()
          ..where((tbl) =>
              tbl.key.equals(PomodoroConfiguration.keyPrefPomodoroLength)))
        .getSingle();
  }
}

class PomodoroConfiguration extends GetxController {
  static const keyPrefPomodoroLength = 'key_pref_pomodoro_length';
  static const keyPrefCycleLength = 'key_pref_cycle_length';
  static const keyPrefShortBreakLength = 'key_pref_short_break_length';
  static const keyPrefLongBreakLength = 'key_pref_long_break_length';

  int get cycleLength => _cycleLength.value;

  set cycleLength(int value) {}

  int get pomodoroLength => _pomodoroLength.value;

  set pomodoroLength(int value) {}

  int get shortBreakLength => _shortBreakLength.value;

  set shortBreakLength(int value) {}

  int get longBreakLength => _longBreakLength.value;

  set longBreakLength(int value) {}

  final RxInt _pomodoroLength = InitRawConfiguration.pomodoroLength.obs;
  final RxInt _cycleLength = InitRawConfiguration.cycleLength.obs;
  final RxInt _shortBreakLength = InitRawConfiguration.shortBreakLength.obs;
  final RxInt _longBreakLength = InitRawConfiguration.longBreakLength.obs;
}
