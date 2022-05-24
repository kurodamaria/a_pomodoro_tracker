import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get title => text()();

  IntColumn get totalPomodoro => integer()();
}

class FinishedTasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get finishedAt => dateTime().withDefault(currentDateAndTime)();

  /// The length of this finished pomodoro, in minutes.
  IntColumn get pomodoroLength => integer()();

  TextColumn get title => text()();
}

@DriftDatabase(tables: [Tasks, FinishedTasks])
class PomodoroDatabase extends _$PomodoroDatabase {
  PomodoroDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

// @override
// MigrationStrategy get migration {
//   return MigrationStrategy(
//     onCreate: (Migrator m) async {
//       await m.createAll();
//     },
//     onUpgrade: (Migrator m, int from, int to) async {},
//   );
// }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
