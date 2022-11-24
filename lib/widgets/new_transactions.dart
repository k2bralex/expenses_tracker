import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({super.key, required this.addHandler, Transaction? edited}) {
    this.edited = edited;
  }

  Transaction? edited;

  final Function addHandler;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  late var _titleController = TextEditingController();
  late var _amountController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.edited != null) {
      _titleController = TextEditingController(text: widget.edited!.title);
      _amountController =
          TextEditingController(text: widget.edited!.amount.toString());
      _selectedDate = widget.edited!.date;
      print(_selectedDate.toString());
    }
  }

  void _submit() {
    final newTitle = _titleController.text;
    final newAmount = double.tryParse(_amountController.text) ?? 0.0;

    if (newTitle.isEmpty || newAmount <= 0.0 || _selectedDate == null) {
      return;
    }

    widget.addHandler(newTitle, newAmount, _selectedDate!);

    Navigator.of(context).pop();
  }

  void _presentDayPicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                keyboardType: TextInputType.text,
                controller: _titleController,
                onSubmitted: (_) => _submit(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                ],
              ),
              SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date chosen!'
                          : 'Picked data: ${DateFormat().add_yMd().format(_selectedDate!)}',
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            onPressed: _presentDayPicker,
                            child: const Text(
                              'Choose Date',
                            ),
                          )
                        : TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.purple),
                            ),
                            onPressed: _presentDayPicker,
                            child: const Text(
                              'Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                  ],
                ),
              ),
              Platform.isIOS ? CupertinoButton.filled(onPressed: _submit, child: const Text('Add transaction')) : ElevatedButton(
                onPressed: _submit,
                child: const Text('Add transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
