import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/domain/entities/user.dart';
import 'package:asistencia_jaguar/presentation/providers/user_p/user_provider.dart';
import 'package:asistencia_jaguar/presentation/screens/screens.dart';
import 'package:asistencia_jaguar/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return ref.watch(userNotifierProvider).when(
      data: (users) {
        if (users.isEmpty) {
          return EmptyPage(
            title: 'Usuarios',
            message: 'No hay usuarios registrados, agrega uno',
            icon: Icons.person_add,
            onPressed: () =>
                appRouter.pushNamed(Routes.adminUserForm.name),
            buttonText: 'Agregar Nuevo Usuario',
          );
        }

        return SafeArea(
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text('Usuarios'),
                  floating: true,
                ),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: FilterChip(
                          label: const Text('Todos'),
                          showCheckmark: false,
                          side: BorderSide.none,
                          onSelected: (selected) {
                            if (selected) {
                            ref.read(userNotifierProvider.notifier).getAllUsers();
                            }
                          },
                          ),
                        ),
                        ...UserRol.values
                          .where((rol) => rol != UserRol.none)
                          .map(
                            (rol) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FilterChip(
                              label: Text(rol.toSpanish()),
                              selected: ref.watch(userNotifierProvider).maybeWhen(
                                data: (users) =>
                                  users.every((user) => user.rol == rol),
                                orElse: () => false,
                                ),
                              showCheckmark: false,
                              side: BorderSide.none,
                              onSelected: (selected) {
                                if (selected) {
                                  ref
                                    .read(userNotifierProvider.notifier)
                                    .getUsersByRole(rol);
                                } else {
                                  ref
                                    .read(userNotifierProvider.notifier)
                                    .getAllUsers();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == users.length) {
                    return const SizedBox(height: 100);
                    }
                    final user = users[index];
                    final borderColor = user.rol == UserRol.admin
                      ? const Color(0xFF000080)
                      : user.rol == UserRol.teacher
                        ? const Color(0xFF87CEEB)
                        : const Color.fromARGB(255, 213, 185, 27);
                    return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      onTap: () => appRouter.pushNamed(
                        Routes.adminUserRetrieve.name,
                        extra: user.id),
                      leading: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                        width: 4,
                        color: borderColor,
                        ),
                      ),
                      child: ProfileImage(
                        imageUrl: user.image, name: user.lastName),
                      ),
                      title: Text('${user.lastName} ${user.name}'),
                      subtitle: Text(user.email),
                    ),
                    );
                  },
                  childCount: users.length + 1,
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              icon: const Icon(Icons.person_add_alt_1_rounded),
              onPressed: () => appRouter.pushNamed(Routes.adminUserForm.name),
              label: const Text('Agregar'),
            ),
          ),
        );
      },
      loading: () => const LoadingPage(),
      error: (error, stack) => ErrorPage(message: error.toString()),
    );
  }
}