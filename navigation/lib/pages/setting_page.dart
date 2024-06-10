import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("S E T T I N G",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
    );
  }
}