import 'package:asistencia_jaguar/data/models/career_model.dart';
import 'package:asistencia_jaguar/data/typedefs.dart';
import 'package:asistencia_jaguar/domain/entities.dart';
import 'package:csv/csv.dart';

class UserStudent extends User {
  const UserStudent({
    required super.id,
    required super.username,
    required super.name,
    required super.lastName,
    required super.email,
    required super.image,
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
      'rol': rol.name.toUpperCase(),
      'student_profile': {
        'career': studentProfile.carrer.id,
      },
    };
  }

  factory UserStudent.fromCsvRow(List<dynamic> csvRow) { 
    
    return UserStudent.fromJson({
      "id": 0,
      "username" : csvRow[0].toString(),
      "name": csvRow[1].toString(),
      "last_name": csvRow[2].toString(),
      "email": csvRow[3].toString(),
      "image": "",
      "rol": UserRol.student.toJson(),
      "student_profile": {
        "career": CareerModel.fromJson({
          "id": csvRow[4].toString(),
          "code": "",
          "name": "",
          "short_name": "",
          "specialty": "",
        }),
      },
      }
    );
  }
  
  static List<UserStudent> fromCsvTable(List<List<dynamic>> csvTable) {
    return csvTable.skip(1).map((csvRow) 
      => UserStudent.fromCsvRow(csvRow)).toList();
  }

  static List<UserStudent> fromCsvString(String csvString) =>
      UserStudent.fromCsvTable(const CsvToListConverter().convert(csvString));

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