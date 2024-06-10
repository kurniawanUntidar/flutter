import 'package:flutter/material.dart';
import 'package:user_input/pages/counter_page.dart';

void main() {
  runApp(UserInput());
}

class UserInput extends StatelessWidget {
  const UserInput({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterPage(),
    );
  }
}
