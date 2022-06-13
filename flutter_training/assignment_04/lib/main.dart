import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.teal[500],
      appBar: AppBar(
        title: const Text('I am poor'),
        backgroundColor: Colors.teal[900],
      ),
      body: const Center(
        child: Image(
          image: AssetImage('images/icons8-coal-80.png'),
        ),
      ),
    )
  ));
}
