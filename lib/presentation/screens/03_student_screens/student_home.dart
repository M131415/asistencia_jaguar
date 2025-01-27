import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/data/services/remote/02_course_services/groups_api.dart';
import 'package:asistencia_jaguar/data/sources/user_prefreferences.dart';
import 'package:asistencia_jaguar/presentation/providers/dark_mode/dark_mode.dart';
import 'package:asistencia_jaguar/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentHomeScreen extends ConsumerWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isDarkMode = ref.watch(darkModeProvider);
    final goRouter = ref.watch(appRouterProvider);

    final userPref = UserPreferences();

    String imageUrl = '';
    String name = '';

    if(userPref.getUser() == null){
      goRouter.pushNamed('login');
    } else {
      final user = userPref.getUser();
      name = user!.name;
      imageUrl = user.image ?? '';
    }
    

    final groupService  = GroupsService();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance App', style: Theme.of(context).textTheme.headlineSmall,),
        actions: [
            IconButton(
              onPressed: () { ref.read(darkModeProvider.notifier).toggleDarkmode(); }, 
              icon: Icon( isDarkMode ? Icons.light_mode : Icons.dark_mode )
            ),
            PopupMenuButton(
              icon: ProfileImage(imageUrl: imageUrl),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('hola bb $name')
          ),
          ElevatedButton(
            onPressed: () async{
              await groupService.getAllGroups();
            }, 
            child: const Text('Mis Grupos')
          ),
        ],
      )
    );
  }
}