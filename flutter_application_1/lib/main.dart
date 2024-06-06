import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  //==========================================================================================//
  // Variables
  String name = "Dwi Kurniawan";
  int age = 10;
  double pi = 3.14159;
  bool isBeginer = true;

  //==========================================================================================//
  /*
  Basic Math operators:
  1+1 -> 2, add
  4-1 -> 3, subtract
  2*3 -> 6, multiply
  8/2 -> 4, divide
  9%4 -> 1, modulo / reminder

  Comparison Operators: (return value true or false)
  == , Equal to
  != , Not Equal to
  >  , Greater than
  <  , Less than
  >= , Greater or equal to
  <= , less or Equal to

  Logical Operators:
  && , AND (returns true if both side are true)
  || , OR (returns true if at least one side is true)
  !  , NOT (returns flase)

  */
  //==========================================================================================//
  /* CONTROLL FLOW
  if(condition){
    do something
  }

  if(condition){
    do something
  } else{
    do something
  }

   if(condition){
    do something
  } else if(condition){
    do something
  }

  switch (expression){
    case value1:

    break;
    case value2:
    
    break;
    case valueN:
    
    break;
    default:
  }
  
  FOR LOOP

  for(initialization;condition;iteration){

  }

  break -> break out of the loop
  continue -> skip this current itteration

  WHILE LOOP
  while(condition){

  }
  //==========================================================================================//
  FUNCTION / METHOD
  
  'void' means that function returns nothing

  */
  //basic function
  void great() {
    print("Hello World");
  }

  // function with parametes
  void greatPerson(String name) {
    print("Hello " + name);
  }

  //function with return type
  int add(int a, int b) {
    int sum = a + b;
    return sum;
  }

  //==========================================================================================//
  /*  DATA STRUCTURES  */
  //List number = [1,2,3];
  List<int> number = [1, 2, 3];
  List<String> names = ["Andi", "Ubbe", "Ragnar", "Lagertha"];
  void printNumber() {
    for (int i = 0; i < number.length; i++) {
      print(number[i]);
    }
  }

  void printName() {
    for (int i = 0; i < names.length; i++) {
      print(names[i]);
    }
  }

  //==========================================================================================//
  @override
  Widget build(BuildContext context) {
    // if(age > 18){
    //   print("Your age is adult");
    // } else{
    //   print("You are kidies");
    // }

    // for(int i=0; i<10;i++){
    //   if(i==6){
    //     continue;
    //   }
    //   print(i);
    // }

    greatPerson("Andi");
    //print(add(5, 3));
    //printNumber();
    printName();
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }
}
