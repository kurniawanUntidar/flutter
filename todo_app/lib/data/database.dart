import 'package:hive/hive.dart';

class ToDoDataBase{
  List ToDos=[];
  final _myBox = Hive.box("myBox");
  //run this method if this is the 1st time ever opening this app
  void createInitialData(){
    ToDos=[
      ["Example Task 1",false],
      ["Example Task 2",false],
    ];
  }
  // load data from database
  void loadData(){
    ToDos = _myBox.get("TODOLIST");
  }
  //update database
  void updateDataBase(){
    _myBox.put("TODOLIST", ToDos);
  }
}
