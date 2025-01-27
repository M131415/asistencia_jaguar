import 'dart:developer';

import 'package:asistencia_jaguar/config/config.dart';
import 'package:asistencia_jaguar/domain/entities/user.dart';
import 'package:asistencia_jaguar/presentation/providers/student_list_p/student_list.dart';
import 'package:asistencia_jaguar/presentation/screens/screens.dart';
import 'package:asistencia_jaguar/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserListStatus { empty, imported, loading, fail, success }

class UserListFromCSV extends ConsumerStatefulWidget {
  const UserListFromCSV({super.key});

  @override
  ConsumerState<UserListFromCSV> createState() => UserListFromCSVState();
}
class UserListFromCSVState extends ConsumerState<UserListFromCSV> {
  
  UserListStatus currentStatus = UserListStatus.empty;

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(studentListProvider);

    if (currentStatus == UserListStatus.empty) {
      return _userListEmpty(ref, context);
    } else if (currentStatus == UserListStatus.imported) {
      return _userListDataimported(ref, data, context);
    } else if (currentStatus == UserListStatus.loading) {
      return _userListLoading(ref, context);
    } else if (currentStatus == UserListStatus.fail) {
      return _userListFail();
    } else if (currentStatus == UserListStatus.success) {
      return _userListSuccess(ref, context, data);
    } else {
      return Container();
    }
  }

  Widget _userListEmpty(WidgetRef ref, BuildContext context,) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cargar estudiantes desde CSV'),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline_rounded),
              onPressed: () {
                
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Formato requerido del archivo CSV',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FlexColumnWidth(1.2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1.5),
                  4: FlexColumnWidth(0.8),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary
                    ),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('No de control', textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Nombre', textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Apellidos', textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Correo Electrónico', textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Carrera', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  const TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('19520555', textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Juan', textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Perez', textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('19520555@c.tecnm.mx', textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('1', textAlign: TextAlign.center),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Nota: El archivo CSV debe contener las columnas en el orden mostrado.La primera fila debe ser el encabezado.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              CustomButtom(
                width: 300,
                icon: Icons.upload_file, 
                label: 'Cargar archivo CSV', 
                onPressed: () async{
                  final result = await ref.read(studentListProvider.notifier).uploadCSV();
                  if (result) {
                    setState(() {
                      currentStatus = UserListStatus.imported;
                    });
                    if(context.mounted){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Estudiantes cargados exitosamente'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                    
                  } else {
                    if(context.mounted){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error al cargar estudiantes'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    
                  }
                  log('Estado actual: $currentStatus');
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _userListDataimported(WidgetRef ref, List<User> userList, BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Estudiantes importados'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Total \n${userList.length}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    CustomButtom(
                        width: 200,
                        height: 70,
                        icon: Icons.group_add_rounded,
                        label: 'Crear usuarios',
                        onPressed: () async {
                          setState(() {
                            currentStatus = UserListStatus.loading;
                          });
                          final result = await ref.read(studentListProvider.notifier).createUserStudentList(userList);
                          if (result) {
                            if(context.mounted){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Usuarios creados exitosamente'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                            setState(() {
                              currentStatus = UserListStatus.success;
                            });
                          } else {
                            if(context.mounted){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Error al crear usuarios'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                            setState(() {
                              currentStatus = UserListStatus.fail;
                            });
                          }
                        },
                      )
                      
                    
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final user = userList[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                          ),
                          title: Text('${user.lastName} ${user.name}'),
                          subtitle: Text(user.email),
                          trailing: Text(user.username),
                          tileColor: user.id == 0 ? Colors.red[100] : Colors.green[100],
                        ),
                      );
                    },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _userListLoading(WidgetRef ref, BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Creando usuarios...')),
        body: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _userListFail() {
    return const ErrorPage(message: 'Error al crear usuarios');
  }

  Widget _userListSuccess(WidgetRef ref, BuildContext context, List<User> userList) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Estudiantes importados'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Total \n${userList.length}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Creados \n${userList.where((element) => element.id != 0).length}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    CustomButtom(
                        width: 150,
                        height: 70,
                        icon: Icons.arrow_back_rounded,
                        label: 'Regresar',
                        onPressed: () async {
                          setState(() {
                            currentStatus = UserListStatus.loading;
                          });
                          ref.watch(appRouterProvider).pop();
                        },
                      )
                      
                    
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final user = userList[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                          ),
                          title: Text('${user.lastName} ${user.name}'),
                          subtitle: Text(user.email),
                          trailing: Text(user.username),
                          tileColor: user.id == 0 ? Colors.red[100] : Colors.green[100],
                        ),
                      );
                    },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}