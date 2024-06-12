import 'package:flutter/material.dart';
import 'package:todo_app/pages/todo_page.dart';

void main() {
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