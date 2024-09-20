import 'package:asistencia_jaguar/core/app/config/config.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Asistencia Jaguar',
      theme: lightTheme,
      routerConfig: myRouter,
    );
  }
}