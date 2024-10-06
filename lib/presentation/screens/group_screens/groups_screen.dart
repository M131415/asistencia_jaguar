import 'package:asistencia_jaguar/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grupos', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.group_add),
        onPressed: () {
          ref.read(appRouterProvider).pushNamed('addGroups');
        },
      ),
      body: const Column(
        children: [
          Text('Mis grupos')
        ],
      ),
    );
  }
}