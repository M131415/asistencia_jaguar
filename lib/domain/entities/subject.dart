class Subject {

  final String id;
  final String userId;
  final String name;

  Subject({
    required this.id, 
    required this.userId, 
    required this.name, 
  });

  Subject copyWith({
    String? id,
    String? userId,
    String? name,
  }) {
    return Subject(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }
}