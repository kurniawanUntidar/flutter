import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoList extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteList;

  ToDoList(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteList});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(), 
            children: [
            SlidableAction(
              onPressed: deleteList,
              icon: Icons.delete,
              backgroundColor: Colors.redAccent,
              borderRadius: BorderRadius.circular(10),
            )
          ]),
          child: Container(
            padding: EdgeInsets.all(24.0),
            child: Row(
              children: [
                //Check Box
                Checkbox(value: taskCompleted, onChanged: onChanged),
                // Task Name
                Text(
                  taskName,
                  style: TextStyle(
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ));
  }
}
