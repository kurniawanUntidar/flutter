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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [Icon(Icons.settings)],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 245, 137, 118),
                      Color.fromARGB(255, 248, 41, 4)
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight),
                image: DecorationImage(
                    image: AssetImage("assets/images/pattern.png"),
                    fit: BoxFit.fitWidth,
                    repeat: ImageRepeat.repeat)),
          ),
          title: Stack(
            children: [
              Text(
                'GARNER CAM',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = const Color.fromARGB(255, 107, 28, 4)),
              ),
              Text(
                'GARNER CAM',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
