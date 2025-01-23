import 'package:flutter/material.dart';

// Colores base
const seedColor = Color.fromARGB(255, 2, 30, 172);
const primaryBlue = Color.fromARGB(255, 0, 68, 169);

// Colores modo oscuro
const darkBackground = Color.fromARGB(255, 0, 3, 23);
const darkCardColor = Color.fromARGB(255, 0, 8, 72);
const darkTextColor = Colors.white;

// Colores modo claro
const lightBackground = Color.fromRGBO(242, 248, 252, 1);
const lightCardColor = Color.fromARGB(234, 223, 225, 255);
const lightTextColor = Color.fromARGB(255, 0, 8, 72);

class AppTheme {
  final bool isDarkmode;

  AppTheme({required this.isDarkmode});

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: primaryBlue,
        scaffoldBackgroundColor: isDarkmode ? darkBackground : lightBackground,
        appBarTheme: isDarkmode
            ? const AppBarTheme(
                backgroundColor: darkBackground,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: darkTextColor,
                  fontSize: 20,
                ),
                iconTheme: IconThemeData(
                  color: darkTextColor,
                ),
              )
            : const AppBarTheme(
                backgroundColor: lightBackground,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: lightTextColor,
                  fontSize: 20,
                ),
                iconTheme: IconThemeData(
                  color: lightTextColor,
                ),
              ),
        cardTheme: CardTheme(
          color: isDarkmode ? darkCardColor : lightCardColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        listTileTheme: ListTileThemeData(
          tileColor: isDarkmode ? darkCardColor : lightCardColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
}