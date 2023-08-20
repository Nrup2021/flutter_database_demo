import 'package:floor/floor.dart';

@entity
class ToDo {
  @PrimaryKey(autoGenerate: true)
  late final int id;
  late final String task;
  late final String time;
  late final String scheduleTime;
  @ignore
  bool isSelect = false;

  ToDo(this.id, this.task, this.time, this.scheduleTime);
}
