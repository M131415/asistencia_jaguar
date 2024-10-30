import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> customShowAddDialog({
  required BuildContext context, 
  required String title, 
  required Widget content, 
  required VoidCallback onSaveAction
}) async {
  if( Platform.isAndroid ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            MaterialButton(
              onPressed: onSaveAction,
              child: const Text('Agregar'),
            ),
            MaterialButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  } else {
    showCupertinoDialog(
      context: context, 
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: content,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: onSaveAction,
              child: const Text('Agregar'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
            ), 
          ],
        );
      },
    );
  }
}