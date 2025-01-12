import 'package:equatable/equatable.dart';

class SchoolRoom extends Equatable {
  const SchoolRoom({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object?> get props => [id,name];
}