import "package:flutter/material.dart";
import "package:todo_app/util/dialog_box.dart";
import "package:todo_app/util/todo_list.dart";

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  // Text controller in dialog box
  final _controller = TextEditingController();
// list to do task
  List ToDos = [
    ["Learn flutter", false],
    ["KP4 Form", true],
    ["Medical Checkup", false]
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      ToDos[index][1] = !ToDos[index][1];
    });
  }

  void saveNewTask(){
    setState(() {
      ToDos.add([_controller.text,false]);
    });
  }

  void createNewTask() {
    showDialog(context: context, builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: ()=>Navigator.of(context).pop(),
      );
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 236),
      appBar: AppBar(
        elevation: 20,
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        title: Text(
          "TO DO",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 1, 27, 73)),
        ),
      ),

      // body: ListView(
      //   children: [
      //     ToDoList(taskName: "Learn Flutter",taskCompleted: true,onChanged: (p0) => 1,),
      //      ToDoList(taskName: "Medical Checkup",taskCompleted: true,onChanged: (p0) {},),
      //       ToDoList(taskName: "KP4 Form",taskCompleted: true,onChanged: (p0) => 1,),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),backgroundColor: Colors.lightGreen,      ),

      body: ListView.builder(
        itemCount: ToDos.length,
        itemBuilder: (context, index) {
          return ToDoList(
            taskName: ToDos[index][0],
            taskCompleted: ToDos[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
    );
  }
}
