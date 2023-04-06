import 'package:flutter/material.dart';

import 'home_screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge: TextStyle(
              color: Colors.white, fontFamily: 'parisienne', fontSize: 80.0
          ),
        )
      ),
      home: HomeScreen(),
    ),
  );
}

