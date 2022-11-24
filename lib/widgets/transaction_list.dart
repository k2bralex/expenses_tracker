import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'delete_alert_dialog.dart';
import 'no_transaction_holder.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function delete;
  final Function edit;

  const TransactionList(
      {super.key,
      required this.transactions,
      required this.delete,
      required this.edit});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
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
                            onPressed: () =>
                                widget.edit(widget.transactions[index].id),
                            icon: Icon(Icons.edit),
                            color: Colors.green,
                          ),
                          IconButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  DeleteAlertDialog(
                                deleteHandler: widget.delete,
                                id: widget.transactions[index].id,
                              ),
                            ),
                            icon: const Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
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
