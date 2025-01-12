import 'package:asistencia_jaguar/data/typedefs.dart';
import 'package:asistencia_jaguar/domain/entities/career.dart';

class CareerModel extends Career{
  const CareerModel({
    required super.id,
    required super.code,
    required super.name,
    required super.shortName,
    required super.specialty,
  });

  // Constructor para crear una instancia desde un mapa JSON
  CareerModel.fromJson(Json json) : super(
    id: json['id'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
    shortName: json['short_name'] as String,
    specialty: json['speciality'] as String,
  );

  // Método para convertir la instancia en un mapa JSON
  Json toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'short_name': shortName,
      'specialty': specialty,
    };
  }
}