import 'package:floor/floor.dart';
import 'package:my_database/entity/to_do.dart';

@dao
abstract class ToDoDAO {
  @Query("select * from ToDo")
  Future<List<ToDo>> findAllToDo();

  @Query("select * from ToDo order by id desc limit 1")
  Future<ToDo?> getMaxToDo();

  @Query("select * from ToDo order by id desc")
  Stream<List<ToDo>> fetchStreamData();

  @insert
  Future<void> insertToDo(ToDo todo);

  @insert
  Future<List<int>> insertAllToDo(List<ToDo> todo);

  @Query("delete from ToDo where id = :id")
  Future<void> deleteToDo(int id);

  @delete
  Future<int> deleteAll(List<ToDo> list);
}
