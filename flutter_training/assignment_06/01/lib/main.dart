import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
  static const _DICE_FACES = 8;

  void changeDiceFace() {
    setState(() {
      int leftRoll = rollDice();
      int rightRoll = rollDice();

      while (leftRoll == rightRoll) {
        leftRoll = rollDice();
        rightRoll = rollDice();
      }

      leftDiceNumber = leftRoll;
      rightDiceNumber = rightRoll;
    });
  }

  int rollDice() {
    return Random().nextInt(_DICE_FACES) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              child: Image.asset('images/octa0$leftDiceNumber.png'),
              onPressed: changeDiceFace,
            ),
          ),
          Expanded(
            child: TextButton(
              child: Image.asset('images/octa0$rightDiceNumber.png'),
              onPressed: changeDiceFace,
            ),
          ),
        ],
      ),
    );
  }
}
