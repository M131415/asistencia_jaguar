import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/presentation/providers/career_p/career_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminCareerListScreen extends ConsumerWidget {
  const AdminCareerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colorScheme = Theme.of(context).colorScheme;
    final appRouter = ref.watch(appRouterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carreras'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          appRouter.pushNamed(Routes.adminCareer.name);
        }, 
        icon: const Icon(Icons.school_rounded), 
        label: const Text('Agregar Carrera')
      ),
      body: Center(
        child: ref.watch(careerStateProvider).when(
          data: (careers) {
            if (careers.isEmpty) {
              return const Text('No hay carreras registradas');
            }
            return ListView.builder(
                itemCount: careers.length,
                itemBuilder: (context, index) {
                  final career = careers[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(72, 100, 141, 153),
                            blurRadius: 4.0,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8.0),
                        leading: CircleAvatar(
                          radius: 25,
                          child: Text(career.code),
                        ),
                        title: Text(
                          career.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        subtitle: Text(
                          'Especialidad: ${career.specialty}',
                          style: const TextStyle(fontSize: 14.0,),
                        ),
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                child: const Text('Editar'),
                                onTap: () {
                                  appRouter.pushNamed(Routes.adminCareer.name, extra: career);
                                },
                              ),
                              PopupMenuItem(
                                child: const Text('Eliminar'),
                                onTap: () async {
                                  final careerNotifier = ref.read(careerStateProvider.notifier);
                                  final result = await careerNotifier.deleteCareer(career.id);
                                  if (result) {
                                    if (context.mounted){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('Carrera Eliminada Correctamente'),
                                          backgroundColor: Theme.of(context).buttonTheme.colorScheme?.error
                                        ),
                                      );
                                    }        
                                  } else {
                                    if (context.mounted){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: 
                                          const Text('Error al eliminar la carrera'),
                                          backgroundColor: Theme.of(context).buttonTheme.colorScheme!.primary
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ];
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      )
    );
  }
}
