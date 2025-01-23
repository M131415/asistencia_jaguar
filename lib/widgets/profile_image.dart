import 'package:asistencia_jaguar/config/endpoints/enpoints.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {

  final String imageUrl;
  final String? name;
  
  const ProfileImage({
    required this.imageUrl,
    this.name,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    final url = Enpoints.baseApiURL + imageUrl;

    return CircleAvatar(
      child: ClipOval(
        child: imageUrl.isNotEmpty
          ? Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.error,
                color: Colors.red,
              ),
            )
            : name != null && name!.isNotEmpty
              ? FittedBox(
                  fit: BoxFit.contain,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      name![0].toUpperCase(),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                )
              : const Icon(
                Icons.account_circle, 
                ),
      ),
    );  
  }
}