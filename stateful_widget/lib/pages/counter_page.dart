import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
// di dalam class / object kita butuh variabel, method, UI
//variabel
  int _counter = 0;

//method
  void _incrementCounter() {
    setState(() {
      // setState => rebuilds the widget
      /* perbedaan utama dari statelessWidget dengan StatefulWidget adalah
      StatelessWidget tidak pernah berubah sedangkan StatefulWidget berubah berdasarkan state
      */
      _counter++;
    });
  }
  void _decrementState(){
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

//UI

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You pushed the button this many times:"),
            Text(
              _counter.toString(),
              style: TextStyle(fontSize: 40),
            ),
            ElevatedButton(
                onPressed: _incrementCounter, child: Text("Increment!"))
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        //onPressed: () => _counter = 0,
        // nilai _counter berubah tapi state widget tidak berubah
        onPressed:_resetCounter,
        //nilai _counter berubah dan state widget berubah
        child: Text("Reset"),
      ),
    );
  }
}
