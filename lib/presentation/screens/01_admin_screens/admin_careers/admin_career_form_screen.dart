import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/data/models/career_model.dart';
import 'package:asistencia_jaguar/presentation/providers/career_p/career_provider.dart';
import 'package:asistencia_jaguar/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminCareerFormScreen extends ConsumerWidget {
   AdminCareerFormScreen({super.key, this.career});

  final CareerModel? career;

  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _shortNameController = TextEditingController();
  final _specialtyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    if (career != null){
      _codeController.text = career!.code;
      _nameController.text = career!.name;
      _shortNameController.text = career!.shortName;
      _specialtyController.text = career!.specialty;
    }

    final appRouter = ref.watch(appRouterProvider);

    return Scaffold(
      appBar: AppBar(
        title: career != null
            ? const Text('Editando Carrera')
            : const Text('Creando Carrera'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextInput(
                  icon: Icons.copy_rounded, 
                  title: 'Código', 
                  placeholder: 'INFF', 
                  controller: _codeController
                ),

                TextInput(
                  icon: Icons.school, 
                  title: 'Nombre de la carrera', 
                  placeholder: 'INGENIERIA EN INFORMATICA', 
                  controller: _nameController
                ),

                TextInput(
                  icon: Icons.school_outlined, 
                  title: 'Nombre corto', 
                  placeholder: 'ING. INFO.', 
                  controller: _shortNameController
                ),

                TextInput(
                  icon: Icons.copy_rounded, 
                  title: 'Especialidad', 
                  placeholder: 'Desarrollo de aplicaciones móviles', 
                  controller: _specialtyController
                ),

                career != null
                  ? CustomButtom(
                      width: 400,
                      height: 70,
                      icon: Icons.school_rounded, 
                      label: 'Actualizar Carrera', 
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          final updateCareer = CareerModel(
                            id: career!.id,
                            code: _codeController.text,
                            name: _nameController.text,
                            shortName: _shortNameController.text,
                            specialty: _specialtyController.text
                          );
                          final result = await ref.read(careerStateProvider.notifier).updateCareer(career!.id, updateCareer);
                          if (result){
                            appRouter.pop();
                            if(context.mounted){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Carrera Actualizada Correctamente'),
                                  backgroundColor: Theme.of(context).buttonTheme.colorScheme?.primary
                                ),
                              );
                            }
                          } else {
                            if(context.mounted){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Error al actualizar la carrera'),
                                  backgroundColor: Theme.of(context).buttonTheme.colorScheme?.error
                                ),
                              );
                            }
                          }
                        }
                      },
                    )
                  :  CustomButtom(
                      width: 400,
                      height: 70,
                      icon: Icons.school_rounded, 
                      label: 'Crear Carrera', 
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          final newCareer0 = CareerModel(
                            id: 0,
                            code: _codeController.text,
                            name: _nameController.text,
                            shortName: _shortNameController.text,
                            
                            specialty: _specialtyController.text
                          );
                          final result = await ref.read(careerStateProvider.notifier).createCareer(newCareer0);
                          if (result){
                            appRouter.pop();
                            if(context.mounted){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Carrera Creada Correctamente'),
                                  backgroundColor: Theme.of(context).buttonTheme.colorScheme?.primary
                                ),
                              );
                            }
                          } else {
                            if(context.mounted){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Error al crear la carrera'),
                                  backgroundColor: Theme.of(context).buttonTheme.colorScheme?.error
                                ),
                              );
                            }
                          }
                        }
                      },
                ),
               
              ],
            ),
          ),
        ),
      )
    );
  }
}