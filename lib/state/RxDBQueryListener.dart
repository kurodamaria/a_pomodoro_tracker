import 'package:drift/drift.dart';
import 'package:get/get.dart';

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
