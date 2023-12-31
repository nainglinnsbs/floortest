// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ToDoDao? _todoDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ToDo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `task` TEXT, `time` TEXT, `scheduleTime` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ToDoDao get todoDao {
    return _todoDaoInstance ??= _$ToDoDao(database, changeListener);
  }
}

class _$ToDoDao extends ToDoDao {
  _$ToDoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _toDoInsertionAdapter = InsertionAdapter(
            database,
            'ToDo',
            (ToDo item) => <String, Object?>{
                  'id': item.id,
                  'task': item.task,
                  'time': item.time,
                  'scheduleTime': item.scheduleTime
                },
            changeListener),
        _toDoUpdateAdapter = UpdateAdapter(
            database,
            'ToDo',
            ['id'],
            (ToDo item) => <String, Object?>{
                  'id': item.id,
                  'task': item.task,
                  'time': item.time,
                  'scheduleTime': item.scheduleTime
                },
            changeListener),
        _toDoDeletionAdapter = DeletionAdapter(
            database,
            'ToDo',
            ['id'],
            (ToDo item) => <String, Object?>{
                  'id': item.id,
                  'task': item.task,
                  'time': item.time,
                  'scheduleTime': item.scheduleTime
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ToDo> _toDoInsertionAdapter;

  final UpdateAdapter<ToDo> _toDoUpdateAdapter;

  final DeletionAdapter<ToDo> _toDoDeletionAdapter;

  @override
  Stream<List<ToDo>> findAllToDo() {
    return _queryAdapter.queryListStream('SELECT * FROM ToDo',
        mapper: (Map<String, Object?> row) => ToDo(
            id: row['id'] as int?,
            task: row['task'] as String?,
            time: row['time'] as String?,
            scheduleTime: row['scheduleTime'] as String?),
        queryableName: 'ToDo',
        isView: false);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM ToDo WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAllTodo() async {
    await _queryAdapter.queryNoReturn('DELETE FROM ToDO');
  }

  @override
  Future<int> insertTodo(ToDo toDo) {
    return _toDoInsertionAdapter.insertAndReturnId(
        toDo, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertAllToDo(List<ToDo> toDo) {
    return _toDoInsertionAdapter.insertListAndReturnIds(
        toDo, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateToDo(ToDo toDo) async {
    await _toDoUpdateAdapter.update(toDo, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteToDo(ToDo toDo) async {
    await _toDoDeletionAdapter.delete(toDo);
  }
}
