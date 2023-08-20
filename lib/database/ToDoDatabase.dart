import 'dart:async';

import 'package:floor/floor.dart';
import 'package:my_database/dao/to_do_dao.dart';
import 'package:my_database/entity/to_do.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part "ToDoDatabase.g.dart";

@Database(version: 1, entities: [ToDo])
abstract class ToDoDatabase extends FloorDatabase {
  ToDoDAO get toDoDao;
}
