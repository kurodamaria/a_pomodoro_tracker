import 'package:a_pomodoro_tracler/state/TaskListController.dart';
import 'package:a_pomodoro_tracler/state/TimerController.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyIndicator extends StatelessWidget {
  const EmptyIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: Text('Empty'),
      child: Column(
        children: [
          Image.asset('assets/imaegs/empty.jpg'),
          Text('Empty'),
        ],
      ),
    );
  }
}

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Error'),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(),
    );
  }
}

// Display the timer
class TimerDisplay extends StatelessWidget {
  const TimerDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerString = Get.find<TimerController>().timerString;
    return Obx(() {
      return Text(timerString.value,
          style: TextStyle(
            fontSize: 26,
          ));
    });
  }
}

class TimerControllers extends StatelessWidget {
  const TimerControllers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TimerController>();
    return SizedBox(
      width: double.infinity,
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
