import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/data/models/school_room_model.dart';
import 'package:asistencia_jaguar/presentation/providers/school_room_p/school_room_provider.dart';
import 'package:asistencia_jaguar/widgets/custom_show_add_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSchoolRoomListScreen extends ConsumerWidget {
  const AdminSchoolRoomListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appRouter = ref.watch(appRouterProvider);
    final nameController = TextEditingController();
    final colorScheme = Theme.of(context).colorScheme;
    final currentNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aulas'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          customShowAddDialog(
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del aula',
              ),
            ),
              
            context: context,
            onSaveAction: () async{
              final newSchoolRoom = SchoolRoomModel(id: 0, name: nameController.text);
              // Llama al provider para agregar el aula
              final result = await ref.read(schoolRoomStateProvider.notifier).createSchoolRoom(newSchoolRoom);
              
              if (result) {
                appRouter.pop();
                if (context.mounted){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Aula agregada correctamente'),
                      duration: Duration(seconds: 3),
                    )
                  );
                }
              } else {
                if (context.mounted){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error al agregar el aula'),
                      duration: Duration(seconds: 3),
                    )
                  );
                }
              }
            },
            title: 'Agregar Aula'
          );
          
        }, 
        icon: const Icon(Icons.room_rounded),
        label: const Text('Agregar Aula')
      ),
      body: ref.watch(schoolRoomStateProvider).when(
        data: (schoolRooms) => GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: schoolRooms.length,
          itemBuilder: (context, index) => GestureDetector(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.business_outlined,
                    size: 35,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    schoolRooms[index].name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
              ],
              ),
            ),
            onLongPress: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 170,
                    padding: const EdgeInsets.all(4),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(schoolRooms[index].name)),
                        ),
                        ListTile(
                          title: const Text('Editar'),
                          leading: const Icon(Icons.edit),
                          onTap: () async {
                            currentNameController.text = schoolRooms[index].name;
                            customShowAddDialog(
                              content: TextField(
                                controller: currentNameController,
                              ),
                              context: context,
                              onSaveAction: () async {
                                 // Llama al provider para actualizar el aula
                                  final result = await ref.read(schoolRoomStateProvider.notifier).updateSchoolRoom(
                                    schoolRooms[index].id,
                                    SchoolRoomModel(id: schoolRooms[index].id, name: currentNameController.text)
                                  );
                                  appRouter.pop();
                                  if (result) {
                                    if (context.mounted){
                                      appRouter.pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Aula actualizada correctamente'),
                                          duration: Duration(seconds: 3),
                                        )
                                      );
                                    }
                                  } else {
                                    if (context.mounted){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Error al actualizar el aula'),
                                          duration: Duration(seconds: 3),
                                        )
                                      );
                                    }
                                  }
                                  
                              },
                              title: 'Actualizar Aula'
                            );
                          },
                        ),
                        ListTile(
                          title: const Text('Eliminar'),
                          leading: const Icon(Icons.delete),
                          onTap: () async {
                            final result =  await ref.read(schoolRoomStateProvider.notifier).deleteSchoolRoom(schoolRooms[index].id);
                            appRouter.pop();
                            if (result) {
                              if (context.mounted){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Aula eliminada correctamente'),
                                    duration: Duration(seconds: 3),
                                  )
                                );
                              }
                            } else {
                              if (context.mounted){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Error al eliminar el aula'),
                                    duration: Duration(seconds: 3),
                                  )
                                );
                              }
                            }
                          },
                        )
                      ],
                    ),
                  );
                }
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      )
    );
  }
}

/* schoolRooms.when(
              data: (schoolRooms) => Flexible(
                child: CustomScrollView(
                  slivers: <Widget>[
              
                    SliverGrid.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisExtent: 70,
                        maxCrossAxisExtent: 70,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      
                      itemCount: schoolRooms.length,
                      itemBuilder: (context, index) {

                        SchoolRoom schoolRoom = schoolRooms[index];

                        return GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              schoolRoom.name!, 
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary
                              ),
                            )
                          ),
                          onLongPress: () {
                            
                        );
                      }
                    )
                  ],
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('Error: $error')),
              ) */