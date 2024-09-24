import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/config/themes/theme_ligth.dart';
import 'package:asistencia_jaguar/simple_bloc_observable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Asistencia Jaguar',
        theme: AppTheme( isDarkmode: false).getTheme(),
        routerConfig: myRouter(),
      );
  }
}