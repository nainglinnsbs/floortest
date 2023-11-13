import 'package:floor/floor.dart';
import 'package:floortest/floor/model/todo.dart';

@dao
abstract class ToDoDao {
  @Query("SELECT * FROM ToDo")
  Stream<List<ToDo>> findAllToDo();

  @insert
  Future<int> insertTodo(ToDo toDo);

  @insert
  Future<List<int>> insertAllToDo(List<ToDo> toDo);

  @Query("DELETE FROM ToDo WHERE id = :id")
  Future<void> deleteTodo(int id);

  @Query('DELETE FROM ToDO')
  Future<void> deleteAllTodo();

  @update
  Future<void> updateToDo(ToDo toDo);

  @delete
  Future<void> deleteToDo(ToDo toDo);
}
