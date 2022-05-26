import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef ItemWidgetBuilder<T> = Widget Function(
    BuildContext context, T item, int index);

class DBQueryDLView extends StatelessWidget {
  const DBQueryDLView({Key? key, required this.dataList, required this.builder})
      : super(key: key);

  final RxList dataList;
  final ItemWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemBuilder: (context, index) =>
            builder(context, dataList[index], index),
        itemCount: dataList.length,
        shrinkWrap: true,
      );
    });
  }
}
