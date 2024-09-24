import 'package:asistencia_jaguar/config/config.dart';
import 'package:asistencia_jaguar/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appRouter = ref.watch(appRouterProvider);
    final isDarkMode = ref.watch(darkModeProvider);

    return  MaterialApp.router (
        debugShowCheckedModeBanner: false,
        title: 'Asistencia Jaguar',
        theme: AppTheme( isDarkmode: isDarkMode).getTheme(),
        routerConfig: appRouter,
      );
  }
}