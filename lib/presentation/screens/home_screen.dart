import 'package:asistencia_jaguar/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {

    final isDarkMode = ref.watch(darkModeProvider);
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Attendace App', style: Theme.of(context).textTheme.headlineSmall,),
          actions: [
            IconButton(
              onPressed: () { ref.read(darkModeProvider.notifier).toggleDarkmode(); }, 
              icon: Icon( isDarkMode ? Icons.light_mode : Icons.dark_mode )
            ),
            PopupMenuButton(
              icon: const Icon(Icons.account_circle),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(child: Text('Perfil')),
                  const PopupMenuItem(child: Text('Cerrar sesión')),
                ];
              },),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            children: [
              Center(
                child: Text('Bienvenido bb')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
