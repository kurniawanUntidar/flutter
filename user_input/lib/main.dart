import 'package:flutter/material.dart';

void main() {
  runApp(const UserInputApp());
}
class UserInputApp extends StatelessWidget {
  const UserInputApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 242, 219, 247),
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text("User Input App",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow),),
        ),
      ),
    );
  }
}