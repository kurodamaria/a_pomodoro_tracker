import 'dart:async';

import 'package:a_pomodoro_tracler/db/db.dart';
import 'package:drift/drift.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final _timeFormat = DateFormat.Hms();

extension on Duration {
  String toMinuteString() {
    int minutes = inMinutes;
    int seconds = inSeconds - minutes * 60;
    return '${minutes < 10 ? '0' : ''}$minutes:${seconds < 10 ? '0' : ''}$seconds';
  }
}

enum TimerControllerStatus {
  initial,
  running,
  finished,
  canceled,
  pausing,
}

class TimerController extends GetxController {
  Timer? _timer;
  final Duration _duration;
  final RxInt _pomodoroDuration;
  final Rx<TimerControllerStatus> status;

  final RxString timerString;

  TimerController({required Duration pomodoroDuration})
      : _duration = pomodoroDuration,
        _pomodoroDuration = pomodoroDuration.inSeconds.obs,
        timerString = pomodoroDuration.toMinuteString().obs,
        status = TimerControllerStatus.initial.obs {
    ever<int>(_pomodoroDuration, (value) {
      timerString.value = Duration(seconds: value).toMinuteString();
    });
  }

  void startTimer() {
    status.value = TimerControllerStatus.running;
    _timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      --_pomodoroDuration.value;
      if (_pomodoroDuration.value == 0) {
        status.value = TimerControllerStatus.finished;
      }
      // -1 delays the timer string update to make it look more "natural"
      if (_pomodoroDuration.value == -1) {
        resetTimer();
      }
    });
  }

  void cancelTimer() {
    status.value = TimerControllerStatus.canceled;
    resetTimer();
  }

  void resetTimer() {
    _timer?.cancel();
    _timer = null;
    _pomodoroDuration.value = _duration.inSeconds;
  }

  bool get isTimerRunning => _timer != null;

  void pauseTimer() {
    status.value = TimerControllerStatus.pausing;
    _timer?.cancel();
    _timer = null;
  }
}

class RxDBQueryListener<T> {
  final MultiSelectable<T> query;
  final RxList<T> dataList = RxList<T>();

  /// [onData] get called when there is new data from the query,
  /// but before [dataList] is updated.
  ///
  /// To perform some action **after** [dataList] has been updated,
  /// just listen to the list.
  void Function(List<T> event)? onData;

  RxDBQueryListener({this.onData, required this.query}) {
    init();
  }

  void init() {
    query.watch().listen((event) {
      Get.log('event arrived');
      onData?.call(event);
      dataList.clear();
      dataList.addAll(event);
    });
  }
}

class TaskListController extends GetxController {
  final _db = Get.find<PomoDatabase>();
  final _fc = Get.find<FinishedTasksController>();
  late final RxDBQueryListener<Task> queryListener;

  final estimatedFinishingTime = ''.obs;

  TaskListController() {
    queryListener = RxDBQueryListener(query: _db.select(_db.tasks));
    ever<List<Task>>(queryListener.dataList, (curTaskList) {
      var pomodoros = 0;
      if (curTaskList.isNotEmpty) {
        pomodoros = curTaskList
            .map((e) => e.totalPomodoro)
            .reduce((value, element) => value + element);
      }
      final estTime = DateTime.now().add(Duration(minutes: pomodoros * 25));
      estimatedFinishingTime.value = _timeFormat.format(estTime);
    });

    ever<TimerControllerStatus>(Get.find<TimerController>().status, (status) {
      if (status == TimerControllerStatus.finished) {
        if (queryListener.dataList.isNotEmpty) {
          finishOne(queryListener.dataList.first);
        }
      }
    });
  }

  void addTask(String title) {
    final newTask = TasksCompanion.insert(
      title: title,
      totalPomodoro: 1,
    );

    _db.into(_db.tasks).insert(newTask);
  }

  void deleteTask(Task task) {
    _db.delete(_db.tasks)
      ..where((tbl) => tbl.id.equals(task.id))
      ..go();
  }

  void updateTask(Task task) {
    _db.update(_db.tasks).replace(task);
  }

  void finishOne(Task task) {
    final t = task.copyWith(totalPomodoro: task.totalPomodoro - 1);
    if (t.totalPomodoro == 0) {
      finish(task);
    } else {
      updateTask(t);
    }
  }

  void finish(Task task) {
    deleteTask(task);
    _fc._finishTask(task);
  }

  void increasePomodoroCount(Task task, int i) {
    final increased = task.copyWith(totalPomodoro: task.totalPomodoro + i);
    updateTask(increased);
  }
}

class FinishedTasksController extends GetxController {
  final _db = Get.find<PomoDatabase>();

  MultiSelectable<FinishedTask> get allFinishedTasks =>
      _db.select(_db.finishedTasks);

  MultiSelectable<FinishedTask> get finishedTasksOfToday =>
      _db.select(_db.finishedTasks)
        ..where((tbl) => tbl.finishedAt.day.equals(DateTime.now().day));

  void _finishTask(Task task) {
    final ft = FinishedTasksCompanion.insert(
      // todo set global preference
      pomodoroLength: 25,
      title: task.title,
    );

    _db.into(_db.finishedTasks).insert(ft);
  }
}
