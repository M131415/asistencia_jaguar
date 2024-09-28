import 'package:asistencia_jaguar/config/config.dart';
import 'package:asistencia_jaguar/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final showName = ref.watch(showNameProvider);
    final isDarkMode = ref.watch(darkModeProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendace App', style: Theme.of(context).textTheme.headlineSmall,),
        actions: [
          IconButton(
            onPressed: () { ref.read(darkModeProvider.notifier).toggleDarkmode(); }, 
            icon: Icon( isDarkMode ? Icons.light_mode : Icons.dark_mode )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.people),
        onPressed: () {
          ref.read(appRouterProvider).goNamed('groups');
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Text('Bienvenido $showName')
            ),
          ],
        ),
      ),
    );
  }
}
