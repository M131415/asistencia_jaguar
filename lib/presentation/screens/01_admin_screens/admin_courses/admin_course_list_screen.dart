import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminCourseListScreen extends ConsumerWidget {
  const AdminCourseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  return Scaffold(
      appBar: AppBar(
        title: Text('Cursos', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          
        }, 
        label: const Text('Curso'),
        icon: const Icon(Icons.bookmark_add),
      ),  
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: Column(
          children: [
            Text('Cursos', style: Theme.of(context).textTheme.headlineMedium,),
          ],
        )
      ),
    );
  }
}
