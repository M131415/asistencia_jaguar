import 'package:flutter/material.dart';

class AdminReportsScreen extends StatelessWidget {
  const AdminReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportes', style: Theme.of(context).textTheme.headlineSmall,),
      ),  
      body: const Center(
        child: Text('Reportes'),
      )
    );
  }
}