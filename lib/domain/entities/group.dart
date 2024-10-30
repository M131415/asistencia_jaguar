

class Group {

  final String id;
  final String subjectId;
  final String name;

  Group({
    required this.id, 
    required this.subjectId, 
    required this.name, 
  });

  Group copyWith({
    String? id,
    String? subjectId,
    String? name,
  }) {
    return Group(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      name: name ?? this.name,
    );
  }
}