import 'package:equatable/equatable.dart';

class Career extends Equatable {
  const Career({
    required this.id,
    required this.code,
    required this.name,
    required this.shortName,
    required this.specialty,
  });

  final int id;
  final String code;
  final String name;
  final String shortName;
  final String specialty;

  @override
  List<Object?> get props => [id, code, name, shortName, specialty];
}