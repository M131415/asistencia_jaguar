import 'package:asistencia_jaguar/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key, required this.title, required this.message, required this.icon, this.onPressed, this.buttonText});

  final String title;
  final String message;
  final IconData icon;
  final String? buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body:Container(
        padding: const EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: 150,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomButtom(
                width: 400,
                icon: icon, 
                label: buttonText ?? 'Agregar', 
                onPressed: onPressed ?? (){}
              )
            ],
          ),
      ),
      
    ));
  }
}