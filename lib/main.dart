import 'package:a_pomodoro_tracler/db/db.dart';
import 'package:a_pomodoro_tracler/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(PomoDatabase());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final timerController =
      Get.put(TimerController(pomodoroDuration: const Duration(seconds: 3)));
  final finishedTasksController = Get.put(FinishedTasksController());
  final taskListController = Get.put(TaskListController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark().copyWith(
          textButtonTheme: const TextButtonThemeData(
              style: const ButtonStyle(
                  // foregroundColor: MaterialStateProperty.(Colors.black),
                  ))),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = Get.find<TimerController>().status;
    return Scaffold(
      appBar: AppBar(
        // title: const Text("A Pomodoro Tracker"),
        // title: Obx(() {
        //   return Text('${s.value.toString()}');
        // }),
        title: Text('Pomodoro Tracker'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const TimerDisplay(),
                  const TimerControllers(),
                  SizedBox(height: 16),
                  const TaskAdder(),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: TaskListView(),
            ),
            Divider(),
            EstimatedFinishingTime(),
            SizedBox(height: 24),
          ],
        ),
      ),
      // bottomSheet: BottomSheet(
      //   builder: (BuildContext context) {
      //     return Container(
      //       height: 300,
      //       color: Colors.blue,
      //       child: DbQueryListBuilder(
      //         query: Get.find<FinishedTasksController>().allFinishedTasks,
      //         itemBuilder:
      //             (BuildContext context, int index, FinishedTask item) {
      //           return Text('${item.title} - ${item.finishedAt}');
      //         },
      //       ),
      //     );
      //   },
      //   onClosing: () {},
      // ),
    );
  }
}
