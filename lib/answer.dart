import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;
  const Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextButton(
        child: Text(answerText),
        onPressed: selectHandler,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),
    );
  }
}
