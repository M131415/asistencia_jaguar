import 'package:asistencia_jaguar/data/models/career_model.dart';
import 'package:asistencia_jaguar/data/typedefs.dart';
import 'package:asistencia_jaguar/domain/entities.dart';
import 'package:csv/csv.dart';

// Modelo del Usuario Estudiante solo para obtener su informacion
class UserStudent extends User {
  const UserStudent({
    required super.id,
    required super.username,
    required super.name,
    required super.lastName,
    required super.email,
    super.image,
    required super.rol,
    required this.studentProfile,
  });

  final StudentProfile studentProfile;

  // Constructor para crear una instancia desde un mapa JSON
  UserStudent.fromJson(Json json) : 
    studentProfile = StudentProfile.fromJson(json['student_profile'] as Json),
    super(
      id: json['id'] as int,
      username: json['username'] as String,
      name: json['name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
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
      'rol': rol.name.toUpperCase(),
      'student_profile': {
        'career': studentProfile.carrer.id,
      },
    };
  }

}

class StudentProfile {
  StudentProfile({
    required this.id,
    required this.carrer,
  });
  final int id;
  final CareerModel carrer;

  // Constructor para crear una instancia desde un mapa JSON
  StudentProfile.fromJson(Json json) : 
    id = json['id'] as int,
    carrer = CareerModel.fromJson(json['career'] as Json);

  // Método para convertir la instancia en un mapa JSON
  Json toJson() {
    return {
      'id': id,
      'carrer': carrer.id,
    };
  }
}

// Modelo del Usuario Estudiante solo para crear un nuevo usuario
class UserStudentCreate extends User{
  const UserStudentCreate({
    required super.id,
    required super.username,
    required super.name,
    required super.lastName,
    required super.email,
    super.image,
    required super.rol,
    required this.careerId,
    required this.password,
  });

  final int careerId;
  final String password;

  // Método para convertir la instancia en un mapa JSON
  Json toJson() {
    return {
      'username': username,
      'password': password,
      'name': name,
      'last_name': lastName,
      'email': email,
      'image': image,
      'rol': UserRol.student.toJson(),
      'student_profile': {
        'career': careerId,
      },
    };
  }

  factory UserStudentCreate.fromCsvRow(List<dynamic> csvRow) { 
    return UserStudentCreate(
      id      : 0,
      username: csvRow[0].toString(),
      name    : csvRow[1] as String,
      lastName: csvRow[2] as String,
      email   : csvRow[3] as String,
      rol     : UserRol.student,
      careerId: int.parse(csvRow[4].toString()),
      password: csvRow[0].toString(),
    );
  }
  
  static List<UserStudentCreate> fromCsvTable(List<List<dynamic>> csvTable) {
    return csvTable.skip(1).map((csvRow) 
      => UserStudentCreate.fromCsvRow(csvRow)).toList();
  }

  static List<UserStudentCreate> fromCsvString(String csvString) {
    return  UserStudentCreate.fromCsvTable(const CsvToListConverter().convert(csvString));
  }

  @override
  String toString() {
    return 'UserStudentCreate(id: $id, username: $username, name: $name, lastName: $lastName, email: $email, image: $image, rol: $rol, careerId: $careerId, password: $password)';
  }
}