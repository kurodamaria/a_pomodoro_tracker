import 'package:a_pomodoro_tracler/db/db.dart';
import 'package:a_pomodoro_tracler/state/RxDBQueryListener.dart';
import 'package:a_pomodoro_tracler/state/TimerController.dart';
import 'package:a_pomodoro_tracler/utility.dart';
import 'package:drift/drift.dart';
import 'package:get/get.dart';

class FinishedTasksController extends GetxController {
  final _db = Get.find<PomodoroDatabase>();

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

class TaskListController extends GetxController {
  final _db = Get.find<PomodoroDatabase>();
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
      estimatedFinishingTime.value = timeFormat.format(estTime);
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
