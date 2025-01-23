import 'package:asistencia_jaguar/data/typedefs.dart';
import 'package:asistencia_jaguar/domain/entities/user.dart';

class UserAdmin extends User{
  const UserAdmin({
    required super.id,
    required super.username,
    required super.name,
    required super.lastName,
    required super.email,
    required super.image,
    required super.rol,
  });

  // Constructor para crear una instancia desde un mapa JSON
  UserAdmin.fromJson(Json json) : super(
    id: json['id'] as int,
    username: json['username'] as String,
    name: json['name'] as String,
    lastName: json['last_name'] as String,
    email: json['email'] as String,
    image: json['image'] as String,
    rol: UserRol.fromString(json['rol']),
  );

  // Método para convertir la instancia en un mapa JSON
  Json toJson() {
    return {
      'username': username,
      'password': username,
      'name': name,
      'last_name': lastName,
      'email': email,
      //'image': image,
      'rol': rol.toJson(),
    };
  }

}