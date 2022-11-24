import 'dart:io';

import 'package:expenses_tracker/widgets/chart.dart';
import 'package:expenses_tracker/widgets/new_transactions.dart';
import 'package:expenses_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:expenses_tracker/theme/app_theme_data.dart';

import 'models/transaction.dart';
import 'models/transction_list_random_fill.dart';

void main() {
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
  final List<Transaction> _transactionList = transactionListRandomFill(20);

  bool _showChart = false;

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

  void _deleteTransaction(String id) {
    setState(() {
      _transactionList.removeWhere((tr) => tr.id == id);
    });
  }

  void _editTransaction(String id) {
    var editTransaction = _transactionList.firstWhere((tr) => tr.id == id);
    showModalBottomSheet(
        context: context,
        builder: (btx) {
          return GestureDetector(
            onTap: null,
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(
              addHandler: _addNewTransaction,
              edited: editTransaction,
            ),
          );
        });
    _transactionList.removeWhere((tr) => tr.id == id);
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var appBar = AppBar(
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
    );
    final pageBody = LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape)
            Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Chart Hide",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Switch.adaptive(
                          activeColor: Colors.amber,
                          value: _showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = val;
                            });
                          }),
                      Text(
                        "Show",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                _showChart
                    ? SizedBox(
                        height: constraints.maxHeight * 0.75,
                        child: Chart(
                          recentTransactions: _recentTransactionList,
                        ),
                      )
                    : SizedBox(
                        height: constraints.maxHeight * 0.75,
                        child: TransactionList(
                          transactions: _transactionList,
                          delete: _deleteTransaction,
                          edit: _editTransaction,
                        ),
                      ),
              ],
            ),
          if (!isLandscape)
            SizedBox(
              height: constraints.maxHeight * 0.25,
              child: Chart(
                recentTransactions: _recentTransactionList,
              ),
            ),
          if (!isLandscape)
            SizedBox(
              height: constraints.maxHeight * 0.75,
              child: TransactionList(
                transactions: _transactionList,
                delete: _deleteTransaction,
                edit: _editTransaction,
              ),
            ),
        ],
      );
    });
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              middle: Text(
                "Personal Expenses",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            child: SafeArea(child: pageBody),
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startNewTransaction(context),
                    child: const Icon(Icons.add),
                  ),
          );
  }
}
