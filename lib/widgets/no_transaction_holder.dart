import 'package:flutter/material.dart';

class NoTransactionHolder extends StatelessWidget {
  const NoTransactionHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          const Text(
            "Nothing to show here",
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.6,
            child: Image.asset(
              'assets/images/pngegg.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      );
    });
  }
}
