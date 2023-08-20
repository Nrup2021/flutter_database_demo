import '../ToDoDatabase.dart'; // Replace with the actual import path

class DatabaseProvider {
  static final DatabaseProvider _singleton = DatabaseProvider._();

  factory DatabaseProvider() {
    return _singleton;
  }

  DatabaseProvider._();

  Future<ToDoDatabase> get database async {
    return await $FloorToDoDatabase
        .databaseBuilder("to_do_database.db")
        .build();
  }
}
