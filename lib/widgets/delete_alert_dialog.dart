import 'package:flutter/material.dart';

class DeleteAlertDialog extends StatelessWidget {
  final Function deleteHandler;
  final int index;

  const DeleteAlertDialog(
      {super.key, required this.deleteHandler, required this.index});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Selected Transaction?"),
      content: const Text("Sure to delete?"),
      actions: [
        TextButton(
          onPressed: () {
            deleteHandler(index);
            Navigator.of(context).pop();
          },
          child: const Text("Yes"),
        ),
        TextButton(
          onPressed: () => {Navigator.of(context).pop()},
          child: const Text("No"),
        ),
      ],
      backgroundColor: Colors.amber[300],
    );
  }
}
