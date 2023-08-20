// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ToDoDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorToDoDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ToDoDatabaseBuilder databaseBuilder(String name) =>
      _$ToDoDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ToDoDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$ToDoDatabaseBuilder(null);
}

class _$ToDoDatabaseBuilder {
  _$ToDoDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$ToDoDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$ToDoDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<ToDoDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ToDoDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ToDoDatabase extends ToDoDatabase {
  _$ToDoDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ToDoDAO? _toDoDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `ToDo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `task` TEXT NOT NULL, `time` TEXT NOT NULL, `scheduleTime` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ToDoDAO get toDoDao {
    return _toDoDaoInstance ??= _$ToDoDAO(database, changeListener);
  }
}

class _$ToDoDAO extends ToDoDAO {
  _$ToDoDAO(
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

  final DeletionAdapter<ToDo> _toDoDeletionAdapter;

  @override
  Future<List<ToDo>> findAllToDo() async {
    return _queryAdapter.queryList('select * from ToDo',
        mapper: (Map<String, Object?> row) => ToDo(
            row['id'] as int,
            row['task'] as String,
            row['time'] as String,
            row['scheduleTime'] as String));
  }

  @override
  Future<ToDo?> getMaxToDo() async {
    return _queryAdapter.query('select * from ToDo order by id desc limit 1',
        mapper: (Map<String, Object?> row) => ToDo(
            row['id'] as int,
            row['task'] as String,
            row['time'] as String,
            row['scheduleTime'] as String));
  }

  @override
  Stream<List<ToDo>> fetchStreamData() {
    return _queryAdapter.queryListStream('select * from ToDo order by id desc',
        mapper: (Map<String, Object?> row) => ToDo(
            row['id'] as int,
            row['task'] as String,
            row['time'] as String,
            row['scheduleTime'] as String),
        queryableName: 'ToDo',
        isView: false);
  }

  @override
  Future<void> deleteToDo(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from ToDo where id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertToDo(ToDo todo) async {
    await _toDoInsertionAdapter.insert(todo, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertAllToDo(List<ToDo> todo) {
    return _toDoInsertionAdapter.insertListAndReturnIds(
        todo, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteAll(List<ToDo> list) {
    return _toDoDeletionAdapter.deleteListAndReturnChangedRows(list);
  }
}
