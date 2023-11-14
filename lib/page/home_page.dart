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
                  time: Faker().date.time(),
                  scheduleTime: Faker().date.toString(),
                );
                await widget.dao.insertTodo(toDo);
                setState(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        "Created New Item",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: Colors.grey.shade200,
                      duration: const Duration(
                        milliseconds: 1000,
                      ),
                      showCloseIcon: true,
                    ),
                  );
                });
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () async {
                widget.dao.deleteAllTodo();
                setState(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        "Deleted all items",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: Colors.grey.shade200,
                      duration: const Duration(
                        milliseconds: 1000,
                      ),
                    ),
                  );
                });
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
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 15.0),
              child: ListView.builder(
                // ignore: unnecessary_null_comparison
                itemCount: listToDo != null ? listToDo.length : 0,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(4.0),
                    child: Slidable(
                      direction: Axis.horizontal,
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            borderRadius: BorderRadius.circular(10.0),
                            onPressed: (BuildContext context) async {
                              final deleteToDo = listToDo[index];
                              await widget.dao.deleteToDo(deleteToDo);
                              setState(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      "Deleted Item",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    backgroundColor: Colors.grey.shade200,
                                    duration: const Duration(
                                      milliseconds: 1000,
                                    ),
                                  ),
                                );
                              });
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          SlidableAction(
                            padding: const EdgeInsets.all(10.0),
                            borderRadius: BorderRadius.circular(10.0),
                            onPressed: (BuildContext context) async {
                              final updateToDo = listToDo[index];
                              updateToDo.task =
                                  Faker().person.firstName().toString();
                              updateToDo.time = Faker().date.time();
                              updateToDo.scheduleTime =
                                  Faker().internet.email().toString();

                              await widget.dao.updateToDo(updateToDo);
                              setState(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      "Updated Item",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    backgroundColor: Colors.grey.shade200,
                                    duration: const Duration(
                                      milliseconds: 1000,
                                    ),
                                  ),
                                );
                              });
                            },
                            backgroundColor: const Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.update,
                            label: 'Update',
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(left: 10),
                          tileColor: Colors.black12,
                          title: Text("Test Name : ${listToDo[index].task}"),
                          subtitle: Text("Time : ${listToDo[index].time}"),
                        ),
                      ),
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
}
