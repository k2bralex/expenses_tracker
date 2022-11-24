import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData buildThemeData() {
    return ThemeData(
      primarySwatch: Colors.indigo,
      textTheme: ThemeData.light().textTheme.copyWith(
        titleMedium: const TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 17,
        ),
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      fontFamily: 'Kanit',
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
          .copyWith(secondary: Colors.amber),
    );
  }
}