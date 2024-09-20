import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: const Color.fromARGB(255, 219, 227, 255),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Color.fromARGB(255, 111, 101, 101)),
    titleTextStyle: TextStyle(color: Colors.black),
  ),
  textTheme: const TextTheme(
    labelMedium: TextStyle(color: Colors.white),
  )
);