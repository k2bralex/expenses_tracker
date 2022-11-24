import 'package:flutter/material.dart';

class NoTransactionHolder extends StatelessWidget {
  const NoTransactionHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Nothing to show here",
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 300,
          child: Image.asset(
            'assets/images/pngegg.png',
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
