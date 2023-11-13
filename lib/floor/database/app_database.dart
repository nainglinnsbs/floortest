import 'dart:async';
import 'package:floor/floor.dart';
import 'package:floortest/floor/dao/todo_dao.dart';
import 'package:floortest/floor/model/todo.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ToDo])
abstract class AppDatabase extends FloorDatabase {
  ToDoDao get todoDao;
}
