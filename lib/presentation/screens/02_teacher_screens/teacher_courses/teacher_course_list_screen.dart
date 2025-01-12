import 'package:flutter/material.dart';

class TeacherCourseListScreen extends StatelessWidget {
  const TeacherCourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos del Docente', style: Theme.of(context).textTheme.headlineSmall,),
      ),  
      body: const Center(
        child: Text('Cursos del Docente'),
      )
    );
  }
}