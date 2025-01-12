import 'package:equatable/equatable.dart';

enum UserRol {
  admin,
  teacher,
  student,
  none;

  /// Método estático para convertir una cadena a un valor del enum
  static UserRol fromString(String value) {
    switch (value.toUpperCase()) {
      case 'ADMIN':
        return UserRol.admin;
      case 'TEACHER':
        return UserRol.teacher;
      case 'STUDENT':
        return UserRol.student;
      default:
        return UserRol.none;
    }
  }
}

class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.name,
    required this.lastName,
    required this.email,
    required this.image,
    required this.rol,
  });

  final int id;
  final String username;
  final String name;
  final String lastName;
  final String email;
  final String image;
  final UserRol rol;

  @override
  List<Object?> get props => [id, username, name, lastName, email, image, rol];
}