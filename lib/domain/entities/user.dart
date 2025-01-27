import 'package:equatable/equatable.dart';

enum UserRol {
  admin,
  teacher,
  student,
  none;

  /// Método estático para convertir una cadena a un valor del enum
  static UserRol fromString(String value) {
    switch (value.toUpperCase()) {
      case 'ADMIN' || 'ADMINISTRADOR':
        return UserRol.admin;
      case 'TEACHER' || 'DOCENTE':
        return UserRol.teacher;
      case 'STUDENT' || 'ESTUDIANTE':
        return UserRol.student;
      default:
        return UserRol.none;
    }
  }
  // Método para convertir un valor del enum a una cadena
  String toJson() => name.toUpperCase();

  // Método para obtener el nombre del rol en español
  String toSpanish() {
    switch (this) {
      case UserRol.admin:
        return 'Administrador';
      case UserRol.teacher:
        return 'Docente';
      case UserRol.student:
        return 'Estudiante';
      default:
        return 'Sin rol';
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
    this.image,
    required this.rol,
  });

  final int id;
  final String username;
  final String name;
  final String lastName;
  final String email;
  final String? image;
  final UserRol rol;

  @override
  List<Object?> get props => [id, username, name, lastName, email, rol];
}