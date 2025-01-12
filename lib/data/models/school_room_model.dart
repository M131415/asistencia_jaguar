import 'package:asistencia_jaguar/data/typedefs.dart';
import 'package:asistencia_jaguar/domain/entities/school_room.dart';

class SchoolRoomModel extends SchoolRoom{
  const SchoolRoomModel({
    required super.id,
    required super.name,
  });

  // Constructor para crear una instancia desde un mapa JSON
  SchoolRoomModel.fromJson(Json json) : super(
    id: json['id'] as int,
    name: json['name'] as String,
  );

  // Método para convertir la instancia en un mapa JSON
  Json toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}