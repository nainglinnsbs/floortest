import 'package:floor/floor.dart';

@Entity()
class ToDo {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? task;
  final String? time;
  final String? scheduleTime;

  ToDo({this.id, this.task, this.time, this.scheduleTime});
}
