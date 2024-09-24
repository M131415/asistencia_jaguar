import 'package:flutter/material.dart';

const seedColor = Color.fromARGB(255, 17, 7, 80);


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
    
  );

}