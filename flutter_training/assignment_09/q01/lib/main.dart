import 'package:flutter/material.dart';
import 'package:q01/textformat/span_builder.dart';
import 'package:q01/textformat/text_spans.dart';

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
        primarySwatch: Colors.deepPurple,
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
  var isSelected = <bool>[false, false, false];
  String liveText = '';
  Set<TextFormatSpan> spans = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text span'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.deepPurple.shade50,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      liveText,
                      style: SpanBuilder.buildSpan(spans),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 16),
                  child: TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Texto',
                    ),
                    onChanged: (text) {
                      setState(() {
                        liveText = text;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: buildButtons(),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton.extended(
          icon: const Icon(Icons.format_clear),
          label: const Text('Limpar'),
          onPressed: () {
            setState(() {
              spans.clear();
              isSelected = [false, false, false];
            });
          },
        ),
      ),
    );
  }

  ToggleButtons buildButtons() {
    return ToggleButtons(
      color: Colors.deepPurple.shade100,
      children: const <Widget>[
        Icon(Icons.format_bold),
        Icon(Icons.format_italic),
        Icon(Icons.format_underline),
      ],
      onPressed: (int index) {
        setState(() {
          var didAdd = spans.add(TextFormatSpan.values[index])
          if (!didAdd) {
            spans.remove(TextFormatSpan.values[index]);
          }
          isSelected[index] = !isSelected[index];
        });
      },
      isSelected: isSelected,
    );
  }
}
