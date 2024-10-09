import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help!'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 252, 38, 38),
        foregroundColor: Colors.white,
      ),
    );
  }
}
