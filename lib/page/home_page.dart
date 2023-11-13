import 'package:faker/faker.dart';
import 'package:floortest/floor/dao/todo_dao.dart';
import 'package:floortest/floor/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHomePage extends StatefulWidget {
  final ToDoDao dao;
  const MyHomePage({required this.dao, super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Floor Database"),
        actions: [
          IconButton(
              onPressed: () async {
                final toDo = ToDo(
                  task: Faker().person.firstName().toString(),
                  time: Faker().date.toString(),
                  scheduleTime: Faker().date.toString(),
                );
                await widget.dao.insertTodo(toDo);
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () async {
                widget.dao.deleteAllTodo();
                // setState(() {
                //   showSnackBar(scaffoldKey.currentState, 'Clear Success');
                // });
              },
              icon: const Icon(Icons.clear)),
        ],
      ),
      body: StreamBuilder(
        stream: widget.dao.findAllToDo(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var listToDo = snapshot.data as List<ToDo>;
            return Container(
              child: ListView.builder(
                // ignore: unnecessary_null_comparison
                itemCount: listToDo != null ? listToDo.length : 0,
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext context) async {
                            final deleteToDo = listToDo[index];
                            await widget.dao.deleteToDo(deleteToDo);
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                        SlidableAction(
                          onPressed: (BuildContext context) async {
                            final updateToDo = listToDo[index];
                            updateToDo.task =
                                Faker().person.firstName().toString();
                            updateToDo.time =
                                Faker().person.lastName().toString();
                            updateToDo.scheduleTime =
                                Faker().internet.email().toString();

                            await widget.dao.updateToDo(updateToDo);
                          },
                          backgroundColor: const Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.update,
                          label: 'Update',
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(left: 20),
                      tileColor: Colors.black12,
                      title: Text("Test Name : ${listToDo[index].task}"),
                      subtitle: Text("Time : ${listToDo[index].time}"),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  // void showSnackBar(ScaffoldState? currentState, String s) {
  //   final snackBar = SnackBar(
  //     content: Text(s),
  //     duration: const Duration(seconds: 1),
  //   );
  //   currentState!.showSnackBar(snackBar);
  // }
}
