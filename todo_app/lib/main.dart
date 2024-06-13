import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/pages/todo_page.dart';

void main() async{
  //Init Flutter
  await Hive.initFlutter();
  //Open a Box
  var box = await Hive.openBox('myBox');

  runApp(const ToDoApp());
}
class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch:Colors.lightGreen),
      home: ToDoPage(),
    );
  }
}