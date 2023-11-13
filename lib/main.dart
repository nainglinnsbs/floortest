import 'package:floortest/floor/dao/todo_dao.dart';
import 'package:floortest/floor/database/app_database.dart';
import 'package:floortest/page/home_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dataBase = await $FloorAppDatabase.databaseBuilder('todo.db').build();
  final dao = dataBase.todoDao;
  runApp(MyApp(
    dao: dao,
  ));
}

class MyApp extends StatelessWidget {
  final ToDoDao? dao;
  const MyApp({this.dao, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        dao: dao!,
      ),
    );
  }
}
