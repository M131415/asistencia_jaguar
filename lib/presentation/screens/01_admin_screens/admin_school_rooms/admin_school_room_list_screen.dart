import 'dart:developer';

import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/data/models/school_room_model.dart';
import 'package:asistencia_jaguar/presentation/providers/school_room_p/school_room_provider.dart';
import 'package:asistencia_jaguar/presentation/screens/screens.dart';
import 'package:asistencia_jaguar/widgets/custom_show_add_dialog.dart';
import 'package:asistencia_jaguar/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSchoolRoomListScreen extends ConsumerWidget {
  const AdminSchoolRoomListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final nameController = TextEditingController();
    final currentNameController = TextEditingController();

    return ref.watch(schoolRoomStateProvider).when(
      data: (schoolRooms) {
        if (schoolRooms.isEmpty) {
          return EmptyPage(
            title: 'Aulas',
            message: 'No hay aulas registradas, agrega una',
            icon: Icons.business_sharp,
            onPressed: () => _showAddRoomDialog(context, ref, nameController),
            buttonText: 'Agregar Nueva Aula',
          );
        }

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Aulas'),
            ),
            body: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: schoolRooms.length,
              itemBuilder: (context, index) => _buildRoomCard(
                context, 
                ref, 
                schoolRooms[index], 
                currentNameController,
                Theme.of(context).colorScheme,
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _showAddRoomDialog(context, ref, nameController),
              icon: const Icon(Icons.room_rounded),
              label: const Text('Agregar Aula'),
            ),
          ),
        );
      },
      loading: () => const LoadingPage(),
      error: (error, stack) => ErrorPage(message: error.toString()),
    );
  }

  // Métodos auxiliares aquí...
  void _showAddRoomDialog(BuildContext context, WidgetRef ref, TextEditingController controller) {
    // Tu código actual para mostrar el diálogo de agregar
    customShowAddDialog(
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Nombre del aula',
        ),
      ),
      context: context,
      onSaveAction: () async {
        final appRouter = ref.watch(appRouterProvider);
        final newSchoolRoom = SchoolRoomModel(id: 0, name: controller.text);
        final result = await ref.read(schoolRoomStateProvider.notifier)
            .createSchoolRoom(newSchoolRoom);
        if (result) {
          appRouter.pop();
        }
        if (context.mounted) {
          _handleResult(context, ref, result, 'agregada');
        } else {
          log('El contexto no está montado');
        }
      },
      title: 'Agregar Aula'
    );
  }

  Widget _buildRoomCard(BuildContext context, WidgetRef ref, 
      SchoolRoomModel room, TextEditingController controller, ColorScheme colorScheme) {
    return GestureDetector(
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
            const Icon(Icons.business_outlined, size: 35),
            const SizedBox(height: 10),
            Text(
              room.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      onLongPress: () => _showBottomSheet(context, ref, room, controller),
    );
  }

  void _showBottomSheet(BuildContext context, WidgetRef ref, 
      SchoolRoomModel room, TextEditingController controller) {
    // Tu código actual para mostrar el bottom sheet
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => _buildBottomSheetContent(
        context, ref, room, controller
      ),
    );
  }

  Widget _buildBottomSheetContent(BuildContext context, WidgetRef ref, 
      SchoolRoomModel room, TextEditingController controller) {
    final appRouter = ref.watch(appRouterProvider);
    return Container(
      height: 170,
      padding: const EdgeInsets.all(4),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(room.name)),
          ),
          ListTile(
            title: const Text('Editar'),
            leading: const Icon(Icons.edit),
            onTap: () {
              appRouter.pop();
              _showEditDialog(context, ref, room, controller);
            },
          ),
          ListTile(
            title: const Text('Eliminar'),
            leading: const Icon(Icons.delete),
            onTap: () async {
              final result = await ref.read(schoolRoomStateProvider.notifier)
                  .deleteSchoolRoom(room.id);
              appRouter.pop();
              if (context.mounted) {
                _handleResult(context, ref, result, 'eliminada');
              } else {
                log('El contexto no está montado al eliminar un aula');
              }
            },
          ),
        ],
      ),
    );
  }

  void _handleResult(BuildContext context, WidgetRef ref, 
      bool result, String action) {

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result 
          ? 'Aula $action correctamente' 
          : 'Error al ${action.split(' ')[0]} el aula'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, 
      SchoolRoomModel room, TextEditingController controller) {

    controller.text = room.name;
    final appRouter = ref.watch(appRouterProvider);

    customShowAddDialog(
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Nombre del aula',
        ),
      ),
      context: context,
      onSaveAction: () async {
        final updatedRoom = room.copyWith(name: controller.text);
        final result = await ref.read(schoolRoomStateProvider.notifier)
            .updateSchoolRoom(room.id, updatedRoom);
        if (result) {
          appRouter.pop();
        }
        if (context.mounted) {
          _handleResult(context, ref, result, 'actualizada');
        } else {
          log('El contexto no está montado');
        }
      },
      title: 'Editar Aula'
    );
  }
}
