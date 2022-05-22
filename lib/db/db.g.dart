// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final DateTime createdAt;
  final String title;
  final int totalPomodoro;
  Task(
      {required this.id,
      required this.createdAt,
      required this.title,
      required this.totalPomodoro});
  factory Task.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Task(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      totalPomodoro: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_pomodoro'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['title'] = Variable<String>(title);
    map['total_pomodoro'] = Variable<int>(totalPomodoro);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      title: Value(title),
      totalPomodoro: Value(totalPomodoro),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      title: serializer.fromJson<String>(json['title']),
      totalPomodoro: serializer.fromJson<int>(json['totalPomodoro']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'title': serializer.toJson<String>(title),
      'totalPomodoro': serializer.toJson<int>(totalPomodoro),
    };
  }

  Task copyWith(
          {int? id, DateTime? createdAt, String? title, int? totalPomodoro}) =>
      Task(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        title: title ?? this.title,
        totalPomodoro: totalPomodoro ?? this.totalPomodoro,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('title: $title, ')
          ..write('totalPomodoro: $totalPomodoro')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, title, totalPomodoro);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.title == this.title &&
          other.totalPomodoro == this.totalPomodoro);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<String> title;
  final Value<int> totalPomodoro;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.title = const Value.absent(),
    this.totalPomodoro = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required String title,
    required int totalPomodoro,
  })  : title = Value(title),
        totalPomodoro = Value(totalPomodoro);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? title,
    Expression<int>? totalPomodoro,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (title != null) 'title': title,
      if (totalPomodoro != null) 'total_pomodoro': totalPomodoro,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? createdAt,
      Value<String>? title,
      Value<int>? totalPomodoro}) {
    return TasksCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      totalPomodoro: totalPomodoro ?? this.totalPomodoro,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (totalPomodoro.present) {
      map['total_pomodoro'] = Variable<int>(totalPomodoro.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('title: $title, ')
          ..write('totalPomodoro: $totalPomodoro')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _totalPomodoroMeta =
      const VerificationMeta('totalPomodoro');
  @override
  late final GeneratedColumn<int?> totalPomodoro = GeneratedColumn<int?>(
      'total_pomodoro', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, title, totalPomodoro];
  @override
  String get aliasedName => _alias ?? 'tasks';
  @override
  String get actualTableName => 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('total_pomodoro')) {
      context.handle(
          _totalPomodoroMeta,
          totalPomodoro.isAcceptableOrUnknown(
              data['total_pomodoro']!, _totalPomodoroMeta));
    } else if (isInserting) {
      context.missing(_totalPomodoroMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Task.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class FinishedTask extends DataClass implements Insertable<FinishedTask> {
  final int id;
  final DateTime finishedAt;

  /// The length of this finished pomodoro, in minutes.
  final int pomodoroLength;
  final String title;
  FinishedTask(
      {required this.id,
      required this.finishedAt,
      required this.pomodoroLength,
      required this.title});
  factory FinishedTask.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FinishedTask(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      finishedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}finished_at'])!,
      pomodoroLength: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pomodoro_length'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['finished_at'] = Variable<DateTime>(finishedAt);
    map['pomodoro_length'] = Variable<int>(pomodoroLength);
    map['title'] = Variable<String>(title);
    return map;
  }

  FinishedTasksCompanion toCompanion(bool nullToAbsent) {
    return FinishedTasksCompanion(
      id: Value(id),
      finishedAt: Value(finishedAt),
      pomodoroLength: Value(pomodoroLength),
      title: Value(title),
    );
  }

  factory FinishedTask.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinishedTask(
      id: serializer.fromJson<int>(json['id']),
      finishedAt: serializer.fromJson<DateTime>(json['finishedAt']),
      pomodoroLength: serializer.fromJson<int>(json['pomodoroLength']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'finishedAt': serializer.toJson<DateTime>(finishedAt),
      'pomodoroLength': serializer.toJson<int>(pomodoroLength),
      'title': serializer.toJson<String>(title),
    };
  }

  FinishedTask copyWith(
          {int? id,
          DateTime? finishedAt,
          int? pomodoroLength,
          String? title}) =>
      FinishedTask(
        id: id ?? this.id,
        finishedAt: finishedAt ?? this.finishedAt,
        pomodoroLength: pomodoroLength ?? this.pomodoroLength,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('FinishedTask(')
          ..write('id: $id, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('pomodoroLength: $pomodoroLength, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, finishedAt, pomodoroLength, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinishedTask &&
          other.id == this.id &&
          other.finishedAt == this.finishedAt &&
          other.pomodoroLength == this.pomodoroLength &&
          other.title == this.title);
}

class FinishedTasksCompanion extends UpdateCompanion<FinishedTask> {
  final Value<int> id;
  final Value<DateTime> finishedAt;
  final Value<int> pomodoroLength;
  final Value<String> title;
  const FinishedTasksCompanion({
    this.id = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.pomodoroLength = const Value.absent(),
    this.title = const Value.absent(),
  });
  FinishedTasksCompanion.insert({
    this.id = const Value.absent(),
    this.finishedAt = const Value.absent(),
    required int pomodoroLength,
    required String title,
  })  : pomodoroLength = Value(pomodoroLength),
        title = Value(title);
  static Insertable<FinishedTask> custom({
    Expression<int>? id,
    Expression<DateTime>? finishedAt,
    Expression<int>? pomodoroLength,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (finishedAt != null) 'finished_at': finishedAt,
      if (pomodoroLength != null) 'pomodoro_length': pomodoroLength,
      if (title != null) 'title': title,
    });
  }

  FinishedTasksCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? finishedAt,
      Value<int>? pomodoroLength,
      Value<String>? title}) {
    return FinishedTasksCompanion(
      id: id ?? this.id,
      finishedAt: finishedAt ?? this.finishedAt,
      pomodoroLength: pomodoroLength ?? this.pomodoroLength,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<DateTime>(finishedAt.value);
    }
    if (pomodoroLength.present) {
      map['pomodoro_length'] = Variable<int>(pomodoroLength.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinishedTasksCompanion(')
          ..write('id: $id, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('pomodoroLength: $pomodoroLength, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

class $FinishedTasksTable extends FinishedTasks
    with TableInfo<$FinishedTasksTable, FinishedTask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinishedTasksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _finishedAtMeta = const VerificationMeta('finishedAt');
  @override
  late final GeneratedColumn<DateTime?> finishedAt = GeneratedColumn<DateTime?>(
      'finished_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  final VerificationMeta _pomodoroLengthMeta =
      const VerificationMeta('pomodoroLength');
  @override
  late final GeneratedColumn<int?> pomodoroLength = GeneratedColumn<int?>(
      'pomodoro_length', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, finishedAt, pomodoroLength, title];
  @override
  String get aliasedName => _alias ?? 'finished_tasks';
  @override
  String get actualTableName => 'finished_tasks';
  @override
  VerificationContext validateIntegrity(Insertable<FinishedTask> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('finished_at')) {
      context.handle(
          _finishedAtMeta,
          finishedAt.isAcceptableOrUnknown(
              data['finished_at']!, _finishedAtMeta));
    }
    if (data.containsKey('pomodoro_length')) {
      context.handle(
          _pomodoroLengthMeta,
          pomodoroLength.isAcceptableOrUnknown(
              data['pomodoro_length']!, _pomodoroLengthMeta));
    } else if (isInserting) {
      context.missing(_pomodoroLengthMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinishedTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FinishedTask.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FinishedTasksTable createAlias(String alias) {
    return $FinishedTasksTable(attachedDatabase, alias);
  }
}

class Preference extends DataClass implements Insertable<Preference> {
  final String key;
  final Uint8List value;
  Preference({required this.key, required this.value});
  factory Preference.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Preference(
      key: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}key'])!,
      value: const BlobType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<Uint8List>(value);
    return map;
  }

  PreferencesCompanion toCompanion(bool nullToAbsent) {
    return PreferencesCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory Preference.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Preference(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<Uint8List>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<Uint8List>(value),
    };
  }

  Preference copyWith({String? key, Uint8List? value}) => Preference(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('Preference(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Preference &&
          other.key == this.key &&
          other.value == this.value);
}

class PreferencesCompanion extends UpdateCompanion<Preference> {
  final Value<String> key;
  final Value<Uint8List> value;
  const PreferencesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
  });
  PreferencesCompanion.insert({
    required String key,
    required Uint8List value,
  })  : key = Value(key),
        value = Value(value);
  static Insertable<Preference> custom({
    Expression<String>? key,
    Expression<Uint8List>? value,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
    });
  }

  PreferencesCompanion copyWith({Value<String>? key, Value<Uint8List>? value}) {
    return PreferencesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<Uint8List>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferencesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $PreferencesTable extends Preferences
    with TableInfo<$PreferencesTable, Preference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreferencesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String?> key = GeneratedColumn<String?>(
      'key', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<Uint8List?> value = GeneratedColumn<Uint8List?>(
      'value', aliasedName, false,
      type: const BlobType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? 'preferences';
  @override
  String get actualTableName => 'preferences';
  @override
  VerificationContext validateIntegrity(Insertable<Preference> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Preference map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Preference.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PreferencesTable createAlias(String alias) {
    return $PreferencesTable(attachedDatabase, alias);
  }
}

abstract class _$PomodoroDatabase extends GeneratedDatabase {
  _$PomodoroDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TasksTable tasks = $TasksTable(this);
  late final $FinishedTasksTable finishedTasks = $FinishedTasksTable(this);
  late final $PreferencesTable preferences = $PreferencesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [tasks, finishedTasks, preferences];
}
