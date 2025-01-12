import 'package:asistencia_jaguar/data/typedefs.dart';
import 'package:asistencia_jaguar/domain/entities.dart';

class UserTeacher extends User {
  const UserTeacher({
    required super.id,
    required super.username,
    required super.name,
    required super.lastName,
    required super.email,
    required super.image,
    required super.rol,
    required this.teacherProfile,
  });

  final TeacherProfile teacherProfile;

  // Constructor para crear una instancia desde un mapa JSON
  UserTeacher.fromJson(Json json) : 
    teacherProfile = TeacherProfile(
      id: json['teacher_profile']['id'] as int,
      degree: json['teacher_profile']['degree'] as String,
    ),
    super(
      id: json['id'] as int,
      username: json['username'] as String,
      name: json['name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
      rol: json['rol'] as UserRol,
    );

  // Método para convertir la instancia en un mapa JSON
  Json toJson() {
    return {
      'username': username,
      'name': name,
      'last_name': lastName,
      'email': email,
      'image': image,
      'rol': rol.name.toUpperCase(),
      'teacher_profile': teacherProfile.id,
    };
  }

}

class TeacherProfile {
  TeacherProfile({
    required this.id,
    required this.degree,
  });
  final int id;
  final String degree;

  // Constructor para crear una instancia desde un mapa JSON
  TeacherProfile.fromJson(Json json) : 
    id = json['teacher_profile']['id'] as int,
    degree = json['teacher_profile']['degree'] as String;

  // Método para convertir la instancia en un mapa JSON
  Json toJson() {
    return {
      'id': id,
      'degree': degree,
    };
  }
}