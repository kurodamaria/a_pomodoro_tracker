import 'package:a_pomodoro_tracler/db/db.dart';
import 'package:a_pomodoro_tracler/state/TaskListController.dart';
import 'package:a_pomodoro_tracler/state/TimerController.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef DbQueryListItemBuilder<T> = Widget Function(
    BuildContext context, int index, T item);

class DbQueryListBuilder<T> extends StatelessWidget {
  const DbQueryListBuilder(
      {Key? key, required this.query, required this.itemBuilder})
      : super(key: key);

  final MultiSelectable<T> query;

  final DbQueryListItemBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: query.watch(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return EmptyIndicator();
          } else {
            return ListView.builder(
              itemBuilder: (context, index) =>
                  itemBuilder(context, index, snapshot.data![index]),
              itemCount: snapshot.data!.length,
            );
          }
        } else if (snapshot.hasError) {
          return ErrorIndicator();
        } else {
          return LoadingIndicator();
        }
      },
    );
  }
}

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


class EstimatedFinishingTime extends StatelessWidget {
  const EstimatedFinishingTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskListController>();
    return Obx(() {
      return Text(
          'Estimated Finishing Time: ${controller.estimatedFinishingTime.value}');
    });
  }
}

// typedef IndexedWidgetBuilderWithItem<T> = Widget Function(
//     BuildContext context, int index, T item);
//
// class RXListBuilder<T> extends StatelessWidget {
//   const RXListBuilder({Key? key, required this.list, required this.itemBuilder})
//       : super(key: key);
//
//   final RxList<T> list;
//   final IndexedWidgetBuilderWithItem<T> itemBuilder;
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Text('$list');
//       // return ListView.builder(
//       //   itemBuilder: (context, index) =>
//       //       itemBuilder(context, index, list[index]),
//       // );
//     });
//   }
// }
