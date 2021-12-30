import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class Bloc {
  StreamController<int> _controller;

  Bloc() {
    _controller = StreamController(onListen: () {
      Timer.periodic(Duration(seconds: 1), (Timer t) {
        _controller.add(t.tick);
      });
    });
  }

  Stream<int> get stream => _controller.stream;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamProvider.value(
        initialData: 0,
        stream: Bloc().stream,
        child: MaterialApp(
          title: 'Counter with StreamProvider',
          home: CounterPage(),
        ),
      );
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newNumber = Provider.of<int>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Counter with StreamProvider')),
      body: Center(
          child: Text(
        '$newNumber',
        style: TextStyle(fontSize: 80),
      )),
    );
  }
}
