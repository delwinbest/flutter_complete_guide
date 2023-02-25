import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer.dart';
import 'question.dart';

// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var questions = [
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
    int arrLength = questions.length;
    this.setState(() {
      if (_questionIndex == arrLength - 1) {
        _questionIndex = 0;
      } else {
        _questionIndex = _questionIndex + 1;
      }
    });
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("My First App"),
        ),
        body: Column(children: [
          Question(questions[_questionIndex]['questionText']),
          Answer(_answerQuestion),
          Answer(_answerQuestion),
          Answer(_answerQuestion),
        ]),
      ),
    );
  }
}
