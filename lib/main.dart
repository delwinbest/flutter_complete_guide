import 'package:flutter/material.dart';
import 'quiz.dart';
import 'result.dart';

// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _questions = const [
    {
      'questionText': 'What\'s your favourite color?',
      'answers': ['Black', 'Green', 'Blue', 'White']
    },
    {
      'questionText': 'What\'s your favourite animal?',
      'answers': ['Rabbit', 'Snake', 'Elephant', 'Lion']
    },
    {
      'questionText': 'What\'s your favourite food?',
      'answers': ['Beef', 'Chicken', 'Ribs', 'Steak']
    }
  ];
  var _questionIndex = 0;

  _answerQuestion() {
    int arrLength = _questions.length;
    this.setState(() {
      if (_questionIndex < arrLength) {
        _questionIndex = _questionIndex + 1;
      }
    });
    print(_questionIndex);
  }

  _resetQuiz() {
    setState(() {
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("My First App"),
          ),
          body: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questions: _questions,
                  questionIndex: _questionIndex)
              : Result(resetHandler: _resetQuiz)),
    );
  }
}
