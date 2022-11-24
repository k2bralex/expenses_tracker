import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'delete_alert_dialog.dart';
import 'no_transaction_holder.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  void _deleteTransaction(int index) {
    setState(() {
      widget.transactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: widget.transactions.isEmpty
          ? const NoTransactionHolder()
          : ListView.builder(
              itemCount: widget.transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            "\$${widget.transactions[index].amount.toStringAsFixed(2)}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      widget.transactions[index].title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat()
                          .add_yMMMMd()
                          .format(widget.transactions[index].date),
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                          fontStyle: FontStyle.italic),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: null,
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  DeleteAlertDialog(
                                deleteHandler: _deleteTransaction,
                                index: index,
                              ),
                            ),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
