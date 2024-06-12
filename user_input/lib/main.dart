import 'package:flutter/material.dart';
import 'package:user_input/pages/todo_page.dart';

void main() {
  runApp(const UserInputApp());
}
class UserInputApp extends StatelessWidget {
  const UserInputApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoPage(),
    );
  }
}