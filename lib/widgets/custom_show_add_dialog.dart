import 'package:flutter/material.dart';

Future<void> customShowAddDialog({
  required BuildContext context, 
  required String title, 
  required Widget content, 
  required VoidCallback onSaveAction
}) async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: content,
        actions: [
          ElevatedButton(
            onPressed: onSaveAction, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).buttonTheme.colorScheme?.onPrimary
            ),
            child: const Text('Confirmar')
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: const Text('Cancelar')
          ),
        ],
      );
    },
  );
}