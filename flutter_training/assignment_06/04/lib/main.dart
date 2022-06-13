import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Jogo interativo',
            style: TextStyle(color: Colors.black87),
          ),
          elevation: 0,
        ),
        body: GamePage(),
      ),
    ),
  );
}

class GamePage extends StatefulWidget {
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _currentValue = 0;
  String tip = '...';
  final int rolledNumber = Random().nextInt(100) + 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Insira o seu palpite\n',
              style: Theme.of(context).textTheme.headline4
            ),
            Expanded(
              child: NumberPicker(
                value: _currentValue,
                minValue: 0,
                maxValue: 100,
                onChanged: (value) => setState(() => _currentValue = value),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  getTipString(_currentValue),
                  style: Theme.of(context).textTheme.headline2
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTipString(int input) {
    if (input == rolledNumber) return 'ACERTOU!';
    return input < rolledNumber ? 'Maior...' : 'Menor';
  }

}
