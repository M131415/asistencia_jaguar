import 'package:flutter/material.dart';

const seedColor = Color.fromARGB(255, 2, 30, 172);

class AppTheme {

  final bool isDarkmode;

  AppTheme({ required this.isDarkmode });

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDarkmode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: const Color.fromARGB(255, 0, 68, 169),
    cardTheme: CardTheme(
      color: isDarkmode ? const Color.fromARGB(255, 0, 8, 72) : const Color.fromARGB(234, 98, 106, 255),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );

}