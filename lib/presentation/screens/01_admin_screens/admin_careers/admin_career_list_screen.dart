import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/data/models/career_model.dart';
import 'package:asistencia_jaguar/data/services/remote/career_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminCareerListScreen extends ConsumerStatefulWidget {
  const AdminCareerListScreen({super.key});

  @override
  AdminCareersScreenState createState() => AdminCareersScreenState();
}

class AdminCareersScreenState extends ConsumerState<AdminCareerListScreen >{

  final _careerService = CareerService();

  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;
    final appRouter = ref.watch(appRouterProvider);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Carreras'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){appRouter.pushNamed(Routes.adminCareer.name);}, 
        icon: const Icon(Icons.school_rounded), 
        label: const Text('Agregar Carrera')
      ),
      body: FutureBuilder<List<CareerModel>>(
        future: _careerService.getAllCareers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay carreras disponibles.'));
          } else {
            final careers = snapshot.data!;
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
                                final result = await _careerService.deleteCareer(career.id);
                                if (result) {
                                  if (context.mounted){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Carrera Eliminada Correctamente')),
                                    );
                                  }
                                  setState(() {});
                                } else{
                                  if (context.mounted){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Carrera Eliminada Correctamente')),
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
          }
        },
      ),
    );
  }
}
