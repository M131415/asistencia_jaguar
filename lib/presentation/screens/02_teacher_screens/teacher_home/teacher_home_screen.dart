import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/data/sources/user_prefreferences.dart';
import 'package:asistencia_jaguar/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeacherHomeScreen extends ConsumerWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isDarkMode = ref.watch(darkModeProvider);
    final goRouter = ref.watch(appRouterProvider);
    final userPref = UserPreferences();

    final user = userPref.getUser();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance App', style: Theme.of(context).textTheme.headlineSmall,),
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
      body: Column(
        children: [
          Center(
            child: user == null ? const Text("no hay usuario") : Text(user.name)
          ),
        ],
      )
    );
  }
}