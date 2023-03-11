import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';
import 'package:uuid/uuid.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primaryColor: Colors.purple,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
          // appBarTheme: AppBarTheme(
          //   titleTextStyle:
          //       Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
          //             fontFamily: 'OpenSans',
          //             // fontSize: 20,
          //             // fontWeight: FontWeight.bold
          //           ),
          // ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.amber)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final List<Transaction> _userTransactions = [
    Transaction(
        id: const Uuid().v4(),
        title: 'New Shoes',
        amount: 69.99,
        date: DateTime.now()),
    Transaction(
        id: const Uuid().v4(),
        title: 'Groceries',
        amount: 16.99,
        date: DateTime.now()),
    Transaction(
        id: const Uuid().v4(),
        title: 'New Shoes',
        amount: 69.99,
        date: DateTime.now()),
    Transaction(
        id: const Uuid().v4(),
        title: 'Groceries',
        amount: 16.99,
        date: DateTime.now()),
    Transaction(
        id: const Uuid().v4(),
        title: 'New Shoes',
        amount: 69.99,
        date: DateTime.now()),
    Transaction(
        id: const Uuid().v4(),
        title: 'Groceries',
        amount: 16.99,
        date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String newtitle, double newAmount, DateTime chosenDate) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: newtitle,
        amount: newAmount,
        date: chosenDate);

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(addTransaction: _addNewTransaction),
          );
        });
  }

  void _deleteTransaction(String transactionId) {
    setState(() {
      _userTransactions
          .removeWhere((transaction) => transaction.id == transactionId);
    });
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text(
        'Personal Expenses',
        style: TextStyle(
            fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add))
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Show Chart"),
                Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    })
              ],
            ),
            _showChart
                ? SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: Chart(
                      recentTransactions: _recentTransactions,
                    ),
                  )
                : SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: TransactionList(
                        transactions: _userTransactions,
                        deleteHandler: _deleteTransaction),
                  ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
