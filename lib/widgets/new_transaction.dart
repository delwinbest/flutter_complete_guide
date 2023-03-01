import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTransaction;

  NewTransaction({required this.addTransaction, super.key});

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    addTransaction(enteredTitle, enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            autocorrect: true,
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
            onSubmitted: (_) => submitData(),
          ),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => submitData(),
          ),
          TextButton(
            onPressed: () {
              addTransaction(
                  titleController.text, double.parse(amountController.text));
            },
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.purple)),
            child: const Text('Add Transaction'),
          )
        ]),
      ),
    );
  }
}
