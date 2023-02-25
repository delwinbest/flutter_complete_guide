import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  String questionText;

  Question(this.questionText);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(80),
          child: Text(
            questionText,
            style: TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
