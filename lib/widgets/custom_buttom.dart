import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final double? height;
  final double? width;

  const CustomButtom({super.key, required this.icon, required this.label, required this.onPressed, this.height, this.width,});

  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: height ?? 80,
      width: width ?? 160,
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              minimumSize: const Size(double.infinity, 60),
              elevation: 0,
          ),
          icon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              icon,
              color: colorScheme.onPrimary,
            ),
          ),
          onPressed: onPressed, 
          label: Text(
            label,
            style: TextStyle(color: colorScheme.onPrimary),
          )
        ),
    );
  }
}