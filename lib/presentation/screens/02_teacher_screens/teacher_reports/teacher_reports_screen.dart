import 'package:flutter/material.dart';

class TeacherReportsScreen extends StatelessWidget {
  const TeacherReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportes del Docente', style: Theme.of(context).textTheme.headlineSmall,),
      ),  
      body: const Center(
        child: Text('Reportes del Docente'),
      )
    );
  }
}