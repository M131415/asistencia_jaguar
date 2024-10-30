import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

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