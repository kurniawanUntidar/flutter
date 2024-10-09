import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting App'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 252, 38, 38),
        foregroundColor: Colors.white,
      ),
    );
  }
}
