import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          title: Text(
            'Number increment',
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.blue.shade50,
          elevation: 0,
        ),
        body: NumberPage(),
      ),
    ),
  );
}

class NumberPage extends StatefulWidget {
  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  int _number = Random().nextInt(1000);

  void increment() {
    setState(() {
      _number++;
    });
  }

  void decrement() {
    setState(() {
      if (_number == 0) return;
      _number--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            child: FloatingActionButton(
              child: Text('--'),
              onPressed: decrement,
            ),
          ),
          Expanded(
            child: Text(
            _number.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2),
          ),
          Expanded(
            child: FloatingActionButton(
              child: Text('++'),
              onPressed: increment,
            ),
          ),
        ],
      ),
    );
  }
}
