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
      body: const Center(
        child: Text('Grupos'),
      )
    );
  }
}