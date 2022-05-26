import 'package:a_pomodoro_tracler/db/db.dart';
import 'package:a_pomodoro_tracler/pages/settings_page/settings_page.dart';
import 'package:a_pomodoro_tracler/state/PomodoroConfiguration.dart';
import 'package:a_pomodoro_tracler/state/TaskListController.dart';
import 'package:a_pomodoro_tracler/state/TimerController.dart';
import 'package:a_pomodoro_tracler/utility.dart';
import 'package:a_pomodoro_tracler/widgets/DBQueryDLView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.to(() => SettingsPage());
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          _TimerDisplay(),
          _TimerControllers(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: _TaskAdder(),
          ),
          _SectionBadge(child: Text('Tasks')),
          Expanded(child: _TaskListView()),
          // _EstiminationInspector(),
          _SectionBadge(child: Text('Finished')),
          Expanded(child: _TodayFinishedTaskView()),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class _EstiminationInspector extends StatelessWidget {
  const _EstiminationInspector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<TaskListController>();
    return Obx(() {
      final evaluatedFinishTime = evaluateFinishTime(c.queryListener.dataList);
      return Text(evaluatedFinishTime.map((e) => e.toString()).join('\n'));
    });
  }
}

class _SectionBadge extends StatelessWidget {
  const _SectionBadge({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[300],
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: child,
    );
  }
}

class _TimerDisplay extends StatelessWidget {
  const _TimerDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerString = Get.find<TimerController>().timerString;
    return Obx(() {
      return Text(timerString.value,
          style: const TextStyle(
            fontSize: 26,
          ));
    });
  }
}

class _TimerControllers extends StatelessWidget {
  const _TimerControllers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TimerController>();
    return SizedBox(
      child: Obx(() {
        if (controller.status.value == TimerControllerStatus.running) {
          return ElevatedButton(
            onPressed: () {
              Get.find<TimerController>().cancelTimer();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
            child: Text('Cancel'),
          );
        } else {
          return ElevatedButton(
            onPressed: () {
              controller.startTimer();
            },
            child: Text('Start'),
          );
        }
      }),
    );
  }
}

class _TaskListView extends StatelessWidget {
  const _TaskListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskListController>();
    return Obx(() {
      final finishTimes = evaluateFinishTime(controller.queryListener.dataList);
      if (controller.queryListener.dataList.isEmpty) {
        return const _EmptyList();
      }
      return ListView.builder(
        itemBuilder: (context, index) => _TaskTile(
          task: controller.queryListener.dataList[index],
          finishTime: finishTimes[index],
        ),
        itemCount: controller.queryListener.dataList.length,
        shrinkWrap: true,
      );
    });
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Empty'),
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({Key? key, required this.task, required this.finishTime})
      : super(key: key);

  final Task task;
  final DateTime finishTime;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskListController>();
    final config = Get.find<PomodoroConfiguration>();
    return ListTile(
      title: Text(task.title),
      subtitle: Row(
        children: [
          Text('${task.totalPomodoro * config.pomodoroLength} min, finish at '),
          Text(timeFormat.format(finishTime)),
        ],
      ),
      trailing: _PomodoroCount(task: task),
      onTap: () {},
      onLongPress: () {
        controller.deleteTask(task);
      },
    );
  }
}

class _PomodoroCount extends StatelessWidget {
  const _PomodoroCount({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskListController>();
    return TextButton(
      onPressed: () {
        controller.increasePomodoroCount(task, 1);
      },
      onLongPress: () {
        controller.decreasePomodoroCount(task, -1);
      },
      child: Text('${task.totalPomodoro}'),
    );
  }
}

class _TaskAdder extends StatelessWidget {
  const _TaskAdder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final taskListController = Get.find<TaskListController>();

    void addTask() {
      if (controller.value.text.isNotEmpty) {
        taskListController.addTask(controller.value.text);
        controller.clear();
      }
    }

    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
      ),
      controller: controller,
      onEditingComplete: addTask,
    );
  }
}

class _AllFinishedTaskView extends StatelessWidget {
  const _AllFinishedTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fc = Get.find<FinishedTasksController>();
    return DBQueryDLView(
      dataList: fc.allFinishedQL.dataList,
      builder: (_, item, __) => _FinishedTaskTile(task: item),
    );
  }
}

class _TodayFinishedTaskView extends StatelessWidget {
  const _TodayFinishedTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fc = Get.find<FinishedTasksController>();
    return DBQueryDLView(
      dataList: fc.todayFinishedQL.dataList,
      builder: (_, item, __) => _FinishedTaskTile(task: item),
    );
  }
}

class _FinishedTaskTile extends StatelessWidget {
  const _FinishedTaskTile({Key? key, required this.task}) : super(key: key);

  final FinishedTask task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      trailing: Text(minuteFormat.format(task.finishedAt)),
      subtitle: Text('${task.pomodoroLength} min'),
    );
  }
}
