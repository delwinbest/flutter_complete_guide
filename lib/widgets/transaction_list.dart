import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_complete_guide/models/transaction.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Groceries', amount: 16.99, date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _userTransactions
          .map((transaction) => Card(
                  child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple),
                        '\$${transaction.amount}'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        transaction.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.yMd().format(transaction.date),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                ],
              )))
          .toList(),
    );
  }
}
