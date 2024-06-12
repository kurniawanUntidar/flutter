import "package:flutter/material.dart";

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
//text editing controller to get access to what the user typed
  TextEditingController myController = TextEditingController();
  String StringName = "";

  void greetUser() {
    setState(() {
      StringName = "Hello, "+myController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 219, 247),
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "User Input App",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
        ),
      ),
      body: Center(
          child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(StringName),
                  TextField(
                    controller: myController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Text your Name"),
                  ),
                  ElevatedButton(onPressed: greetUser, child: Text("Tap"))
                ],
              ))),
    );
  }
}
