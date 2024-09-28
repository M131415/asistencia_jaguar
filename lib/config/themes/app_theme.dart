import 'package:flutter/material.dart';

const seedColor = Color.fromARGB(255, 26, 229, 80);

class AppTheme {

  final bool isDarkmode;

  AppTheme({ required this.isDarkmode });

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seedColor,
    brightness: isDarkmode ? Brightness.dark : Brightness.light,

    listTileTheme: const ListTileThemeData(
      iconColor: seedColor,
    ),
    scaffoldBackgroundColor: isDarkmode 
      ? const Color.fromARGB(255, 0, 59, 108) 
      : const Color.fromARGB(255, 236, 236, 236),
    
  );

}