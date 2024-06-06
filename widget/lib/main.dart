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
          backgroundColor: Color.fromARGB(255, 143, 4, 207),
          title: Text("Widget App",
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          leading: Icon(Icons.menu),
          actions: [Icon(Icons.logout)],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              color: Colors.blue,
            ),
            Container(
              height: 200,
              width: 200,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
