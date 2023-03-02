import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionList({required this.transactions, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 600,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
                child: Row(children: <Widget>[
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                    style: Theme.of(context).textTheme.titleLarge,
                    '\$${transactions[index].amount.toStringAsFixed(2)}'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transactions[index].title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat.yMd().format(transactions[index].date),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ]));
          },
          itemCount: transactions.length,
        ));
  }
}
