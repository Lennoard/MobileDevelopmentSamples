import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: buildTextFieldRow(1),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: buildTextFieldRow(2),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: buildTextFieldRow(3),
            ),
          ],
        ),
      ),
    );
  }

  Row buildTextFieldRow(int n) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Text(n.toString()),
        ),
        Flexible(
          child: TextField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Exemplo $n',
            ),
          ),
        ),
      ],
    );
  }
}
