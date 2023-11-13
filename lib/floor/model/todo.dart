import 'package:floor/floor.dart';

@Entity()
class ToDo {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? task;
  String? time;
  String? scheduleTime;

  ToDo({this.id, this.task, this.time, this.scheduleTime});
}
