import 'package:flutter/material.dart';

class CounterStateful extends StatefulWidget {
  Color buttonColor;
  CounterStateful({Key? key, required this.buttonColor}) : super(key: key);

  @override
  State<CounterStateful> createState() => _CounterStatefulState();
}

class _CounterStatefulState extends State<CounterStateful> {
  int _counter = 0;
  void increment() {
    setState(() {
      _counter++;
    });
    print("counter: ${_counter}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: widget.buttonColor,
        child: Icon(Icons.add),
        onPressed: () => increment(),
      ),
      appBar: AppBar(),
      body: Center(
        child: Text(
          "value: $_counter",
          style: TextStyle(
              fontSize: 30
          ),
        ),
      ),
    );
  }
}
