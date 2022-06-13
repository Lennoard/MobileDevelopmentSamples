import 'package:flutter/material.dart';

import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade100,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  final List<bool> scores = [];

  double calculateScore() {
    var correctAnswers = scores.where((answer) => answer).length.toDouble();
    var totalAnswers = scores.length.toDouble();

    return (correctAnswers / totalAnswers) * 100;
  }

  void checkAnswer(bool? userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        showFinalScore();
      } else {
        if (userPickedAnswer == null) {
          scoreKeeper.add(
              const Icon(Icons.help_outline_rounded, color: Colors.blueGrey));
        } else if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
          scores.add(true);
        } else {
          scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
          scores.add(false);
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 48, bottom: 8, left: 16, right: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 16.0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.greenAccent.shade700,
                  child: const Icon(Icons.thumb_up),
                  onPressed: () {
                    checkAnswer(true);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.blueGrey.shade700,
                  child: const Icon(Icons.help_outline_rounded),
                  onPressed: () {
                    checkAnswer(null);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.redAccent.shade700,
                  child: const Icon(Icons.thumb_down),
                  onPressed: () {
                    checkAnswer(false);
                  },
                ),
              )
            ],
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }

  void showFinalScore() {
    final SnackBar feedbackSnackbar = SnackBar(
      content: WillPopScope(
        onWillPop: () async {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          reset();
          return true;
        },
        child: Text('Pontuação final: ${calculateScore()}%'),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(feedbackSnackbar).closed;
  }

  void reset() {
    quizBrain.reset();
    scoreKeeper = [];
    scores.clear();
  }
}
