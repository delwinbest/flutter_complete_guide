import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final Function resetHandler;

  const Result({@required this.resetHandler});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('You did it!',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          TextButton(onPressed: resetHandler, child: Text('Reset Quiz'))
        ],
      ),
    );
  }
}
