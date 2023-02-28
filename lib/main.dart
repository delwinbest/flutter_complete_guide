import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: const Card(
                color: Colors.amber,
                elevation: 10,
                child: Text('Chart!'),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        autocorrect: true,
                        autofocus: true,
                        controller: titleController,
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      TextField(
                        controller: amountController,
                        decoration: InputDecoration(labelText: 'Amount'),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
                      TextButton(
                        onPressed: () {
                          print(titleController.text);
                          print(amountController.text);
                        },
                        child: Text('Add Transaction'),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.purple)),
                      )
                    ]),
              ),
            ),
            TransactionList()
          ],
        ));
  }
}
