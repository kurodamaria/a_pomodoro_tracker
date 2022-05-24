import 'dart:async';

import 'package:a_pomodoro_tracler/state/PomodoroConfiguration.dart';
import 'package:a_pomodoro_tracler/utility.dart';
import 'package:get/get.dart';

enum TimerControllerStatus {
  initial,
  running,
  finished,
  canceled,
  pausing,
}

class TimerController extends GetxController {
  Timer? _timer;
  final RxInt _remainSecs;
  final Rx<TimerControllerStatus> status;

  final RxString timerString;

  final PomodoroConfiguration config;

  TimerController({required this.config})
      : _remainSecs = (3).obs,
        timerString =
            minuteString(Duration(minutes: config.pomodoroLength)).obs,
        status = TimerControllerStatus.initial.obs {
    ever<int>(_remainSecs, (value) {
      timerString.value = minuteString(Duration(seconds: value));
    });
  }

  void _timerCb(Timer timer) {
    --_remainSecs.value;
    if (_remainSecs.value == 0) {
      status.value = TimerControllerStatus.finished;
    }
    // -1 delays the timer string update to make it look more "natural"
    if (_remainSecs.value == -1) {
      resetTimer();
    }
  }

  void startTimer() {
    status.value = TimerControllerStatus.running;
    _timer ??= Timer.periodic(const Duration(seconds: 1), _timerCb);
  }

  void cancelTimer() {
    status.value = TimerControllerStatus.canceled;
    resetTimer();
  }

  void resetTimer() {
    _timer?.cancel();
    _timer = null;
    _remainSecs.value = 3;
  }

  bool get isTimerRunning => _timer != null;

  void pauseTimer() {
    status.value = TimerControllerStatus.pausing;
    _timer?.cancel();
    _timer = null;
  }
}
