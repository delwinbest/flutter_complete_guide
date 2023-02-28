import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTransaction;

  NewTransaction({required this.addTransaction, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            autocorrect: true,
            autofocus: true,
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: amountController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          TextButton(
            onPressed: () {
              addTransaction(
                  titleController.text, double.parse(amountController.text));
            },
            child: Text('Add Transaction'),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.purple)),
          )
        ]),
      ),
    );
  }
}
