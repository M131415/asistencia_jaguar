import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/data/sources/user_prefreferences.dart';
import 'package:asistencia_jaguar/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminHomeScreen extends ConsumerStatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<AdminHomeScreen> {
  
  @override
  Widget build(BuildContext context) {

    final isDarkMode = ref.watch(darkModeProvider);
    final goRouter = ref.watch(appRouterProvider);
    final userPref = UserPreferences();
    
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
                  PopupMenuItem(
                    child: const Text('Cerrar sesión'),
                    onTap: () {
                      goRouter.pushNamed(Routes.login.name);
                      userPref.setDefaultValues();
                    },
                  ),
                ];
              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            children: [
              Center(
                child: Text('Cursos del dia')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
