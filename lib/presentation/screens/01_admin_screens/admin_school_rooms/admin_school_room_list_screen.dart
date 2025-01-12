import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/widgets/custom_show_add_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSchoolRoomListScreen extends ConsumerWidget {
  const AdminSchoolRoomListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appRouter = ref.watch(appRouterProvider);
    final name = TextEditingController();
    //final currentName = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aulas'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          customShowAddDialog(
            content: TextField(
              controller: name,
            ),
              
            context: context,
            onSaveAction: () async{
              //final newSchoolRoom = SchoolRoom(name: name.text);
                
              try {
              // Llama al provider para agregar el aula
              appRouter.pop();
              name.clear();

              if (context.mounted){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Aula registrada correctamente'),
                    duration: Duration(seconds: 3),
                  )
                );
              }
              } catch (e) {
                if (context.mounted){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al agregar el aula: $e')),
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Column(
            children: [
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
                                        child: Center(child: Text(schoolRoom.name!)),
                                      ),
                                      ListTile(
                                        title: const Text('Editar'),
                                        leading: const Icon(Icons.edit),
                                        onTap: () async {
                                          currentName.text = schoolRoom.name!;
                                          customShowAddDialog(
                                            
            content: TextField(
              controller: currentName,
            ),
              
            context: context,
            onSaveAction: () async {
                try {
                // Llama al provider para agregar el aula
                appRouter.pop();
                schoolRoom.name = currentName.text;
                await ref.read(editSchoolRoomProvider(schoolRoom.id!, schoolRoom).future);
                name.clear();
                
                
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Aula actualizada correctamente'),
                  duration: Duration(seconds: 3),
                ));
                
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al agregar el aula: $e')),
                );
              }
            },
            title: 'Actualizar Aula'
          );
              }
                                        
                                      ),
                                      ListTile(
                                        title: const Text('Eliminar'),
                                        leading: const Icon(Icons.delete),
                                        onTap: () async{
                                          appRouter.pop();
                                          schoolRoom.name = currentName.text;
                                          await ref.read(deleteSchoolRoomProvider(schoolRoom.id!,).future);
                                        },
                                      )
                                    ],
                                  ),
                                );
                              }
                            );
                          },
                        );
                      }
                    )
                  ],
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('Error: $error')),
              ) */],
          ),
      ),);
  }
}