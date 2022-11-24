import 'package:expenses_tracker/widgets/chart.dart';
import 'package:expenses_tracker/widgets/new_transactions.dart';
import 'package:expenses_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/theme/app_theme_data.dart';

import 'models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: AppThemeData.buildThemeData(),
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
  final List<Transaction> _transactionList = [
    Transaction(
      id: 't1',
      title: 'Transaction1',
      amount: 200.20,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Transaction2',
      amount: 60.10,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Transaction3',
      amount: 18.22,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Transaction4',
      amount: 15.98,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Transaction5',
      amount: 121.45,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactionList {
    return _transactionList.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (btx) {
          return GestureDetector(
            onTap: null,
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(addHandler: _addNewTransaction),
          );
        });
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);

    setState(() {
      _transactionList.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _startNewTransaction(context),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text(
          'Personal Expenses',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(
              recentTransactions: _recentTransactionList,
            ),
            TransactionList(transactions: _transactionList),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
