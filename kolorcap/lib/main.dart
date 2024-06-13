import 'package:flutter/material.dart';
import 'package:kolorcap/pages/camera_page.dart';

void main() {
  runApp(kolorcap());
}
class kolorcap extends StatelessWidget {
  const kolorcap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kolorCap',
      home: CameraPage(),
    );
  }
}
