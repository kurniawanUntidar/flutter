import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // clear debug flag
      home: Scaffold(
//        backgroundColor: Colors.pinkAccent[200],
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(177, 5, 154, 1),
          title: Text("Widget App",
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          leading: Icon(Icons.menu),
          actions: [
            Icon(
              Icons.account_box,
              color: Colors.black,
            ),
            Icon(
              Icons.logout,
              color: Colors.black,
            )
          ],
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 200,
                  width: 200,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 187, 13, 135),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "Kurniawan",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 196, 201, 230),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              Container(
                height: 200,
                width: 200,
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
