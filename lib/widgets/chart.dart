import 'package:expenses_tracker/models/transaction.dart';
import 'package:expenses_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  List<Map<String, dynamic>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double weekDayAmount = recentTransactions
          .where((tr) => tr.date.day == weekDay.day)
          .map((tr) => tr.amount)
          .fold(0, (value, element) => value + element);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': weekDayAmount
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0, (a, b) => a + b['amount']);
  }

  const Chart({super.key, required this.recentTransactions});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: data['day'],
                  amount: data['amount'],
                  ofTotal:
                      totalSpending == 0 ? 0.0 : data['amount'] / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
