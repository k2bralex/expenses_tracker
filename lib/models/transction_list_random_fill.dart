import 'dart:math';

import 'package:expenses_tracker/models/transaction.dart';

List<String> titles = [
  'Water',
  'Coffee',
  'Pasta',
  'Rice',
  'Bread',
  'Meat',
  'Fish',
  'Butter',
  'Milk',
  'Eggs',
  'Cheese',
  'Yogurt',
  'Onions',
  'Garlic',
  'Fruit',
  'Vegetables',
  'Vinegar',
  'Honey'
];

List<Transaction> transactionListRandomFill(int len) {
  return List<Transaction>.generate(len, (index) {
    var tRand = titles.length;

    var now = DateTime.now();
    Random rnd = Random(now.microsecondsSinceEpoch);

    String id = 'tr#$index';
    String title = titles[Random().nextInt(tRand)];
    double amount = 30 + rnd.nextDouble() * Random().nextInt(5)*100;
    DateTime date = DateTime.now().subtract(Duration(days: Random().nextInt(7)));

    return Transaction(id: id, title: title, amount: amount, date: date);
  });
}
