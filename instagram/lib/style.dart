import 'package:flutter/material.dart';

var theme = ThemeData(
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Colors.grey,
    )
  ),

  appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 1, // shadow
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
      actionsIconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: TextTheme(
        bodyMedium: TextStyle(color: Colors.pink)
    ),
);
