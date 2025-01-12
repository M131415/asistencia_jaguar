import 'package:asistencia_jaguar/config/endpoints/enpoints.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {

  final String imageUrl;
  
  const ProfileImage({
    required this.imageUrl,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty
    ? CircleAvatar(
      backgroundColor: Colors.grey[200], // Color de fondo opcional
      child: ClipOval(
        child: Image.network(
          '${Enpoints.baseApiURL}$imageUrl', // URL de la imagen
          width: 100, // Ancho de la imagen
          height: 100, // Alto de la imagen
          fit: BoxFit.cover, // Ajusta la imagen para cubrir el espacio
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.person); // Icono por defecto si hay error
          },
        ),
      ),
    ) : const Icon(Icons.account_circle);
  }
}