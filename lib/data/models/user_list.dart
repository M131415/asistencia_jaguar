import 'package:asistencia_jaguar/data/typedefs.dart';
import 'package:asistencia_jaguar/domain/entities/user.dart';

class UserList extends User{
  const UserList({
    required super.id,
    required super.username,
    required super.name,
    required super.lastName,
    required super.email,
    required super.image,
    required super.rol,
  });

  // Constructor para crear una instancia desde un mapa JSON
  UserList.fromJson(Json json) : super(
    id: json['id'] as int,
    username: json['username'] as String,
    name: json['name'] as String,
    lastName: json['last_name'] as String,
    email: json['email'] as String,
    image: json['image'] as String,
    rol: UserRol.fromString(json['rol']),
  );

  // Método para convertir una instancia a un mapa JSON
  Json toJson() => {
    'id': id,
    'username': username,
    'name': name,
    'last_name': lastName,
    'email': email,
    'image': image,
    'rol': rol.toJson(),
  };

}