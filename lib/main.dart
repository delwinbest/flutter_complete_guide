import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;

  answerQuestion(int arrLength) {
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
    var questions = [
      'What\'s your favourite color?',
      'What\'s your favourite animal?',
      'What\'s your favourite food?'
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("My First App"),
        ),
        body: Column(children: [
          Text(questions.elementAt(_questionIndex)),
          ElevatedButton(
              child: Text("Answer 1"),
              onPressed: () => answerQuestion(questions.length)),
          ElevatedButton(
              child: Text("Answer 2"),
              onPressed: () => answerQuestion(questions.length)),
          ElevatedButton(
              child: Text("Answer 3"),
              onPressed: () => answerQuestion(questions.length)),
        ]),
      ),
    );
  }
}
