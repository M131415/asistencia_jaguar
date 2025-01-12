import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminPanelScreen extends ConsumerWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

  final appRouter = ref.watch(appRouterProvider);

  return Scaffold(
      appBar: AppBar(
        title: Text('Panel de Administrador', style: Theme.of(context).textTheme.headlineSmall,),
      ),  
      body: ListView(
        padding: const EdgeInsets.all(16),
        children:  [
          const SizedBox(height: 30,),
          const Text('Usuarios'),
          const SizedBox(height: 10,),
          
          CustomButtom(
            icon: Icons.person_3, 
            label: 'Usuarios', 
            onPressed: () {},
          ),

          const SizedBox(height: 30,),
          const Text('Información sobre los Cursos'),
          const SizedBox(height: 10,),

          Row(
            children: [
              CustomButtom(
            icon: Icons.pending_actions_outlined, 
            label: 'Cursos', 
            onPressed: () {},
          ),
          
          CustomButtom(
            icon: Icons.people_rounded, 
            label: 'Grupos de Clases', 
            onPressed: () {},
          ),
            ],
          ),

          Row(
            children: [
              CustomButtom(
                icon: Icons.room_rounded, 
                label: 'Aulas', 
                onPressed: () {
                  appRouter.pushNamed('school_rooms');
                },
              ),
              CustomButtom(
                icon: Icons.calendar_month_rounded, 
                label: 'Periodos', 
                onPressed: () {},
              ),
            ],
          ),

          Row(
            children: [
              CustomButtom(
                icon: Icons.book_rounded, 
                label: 'Materias', 
                onPressed: () {},
              ),
              CustomButtom(
                icon: Icons.business_rounded, 
                label: 'Departamentos', 
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              CustomButtom(
                icon: Icons.school_rounded, 
                label: 'Carreras', 
                onPressed: () { appRouter.pushNamed('admin_careers');},
              ),
            ],
          ),

        ],
      )
    );
  }
}
