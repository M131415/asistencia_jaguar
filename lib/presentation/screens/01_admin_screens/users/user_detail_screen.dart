import 'dart:developer';

import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/data/models/user_student.dart';
import 'package:asistencia_jaguar/data/models/user_teacher.dart';
import 'package:asistencia_jaguar/presentation/providers/user_p/user_provider.dart';
import 'package:asistencia_jaguar/presentation/providers/user_p/user_retrieve_provider.dart/user_retrieve_provider.dart';
import 'package:asistencia_jaguar/presentation/screens/screens.dart';
import 'package:asistencia_jaguar/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetailScreen extends ConsumerWidget {
  const UserDetailScreen({super.key, this.userId});

  final int? userId;

  @override
  Widget build(BuildContext context, WidgetRef ref){

    if (userId == null) {
      return const Scaffold(
        body: Center(
          child: Text('Usuario no encontrado'),
        ),
      );
    }

    return ref.watch(UserRetrieveProvider(userId!)).when(
      data: (user) {
        log(user.runtimeType.toString());
        Widget extraInfo;
        
        if (user is UserTeacher) {
          extraInfo = Text('Grado: ${user.teacherProfile.degree}');
        } else if (user is UserStudent) {
          extraInfo = Text('Carrera: ${user.studentProfile.carrer.shortName}');
        } else {
          extraInfo = const SizedBox.shrink(); // No extra info for admin
        }

        final appRouter = ref.read(appRouterProvider);

        return Scaffold(
          appBar: AppBar(
            title: Text(user.lastName),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  appRouter.pushNamed(
                    Routes.adminUserUpdate.name,
                    extra: user,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async{
                  
                  final result = await ref.read(userNotifierProvider.notifier).deleteUser(user.id);

                  if (result) {
                    appRouter.pop();
                    if(context.mounted){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Usuario eliminado'),
                        ),
                      );
                    }
                  } else {
                    if(context.mounted){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error al eliminar usuario'),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 100,
                        width: 100,
                        child: ProfileImage(
                          imageUrl: user.image,
                          name: user.name,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${user.name} ${user.lastName}'),
                          Text(user.username),
                          Text(user.email),

                          extraInfo,
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
        );
      },
      loading: () => const LoadingPage(),
      error: (error, _) => ErrorPage(message: error.toString()),
    );
  }
}