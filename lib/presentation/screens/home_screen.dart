import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendace App', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.people),
        onPressed: () {
          context.goNamed('addGroup');
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const Column(
          children: [
            Center(
              child: Text('Hola bbs jaguares')
            ),
          ],
        ),
      ),
    );
  }
}
