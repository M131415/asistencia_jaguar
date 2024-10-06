import 'package:asistencia_jaguar/domain/entities/subject.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subject_list.g.dart';

@riverpod
class SubjectList extends _$SubjectList {

  List<Subject> subjectList = [];
  String userId = '1';

  @override
  List<Subject> build() {
    for (Subject sub in getSubjetList()){
      subjectList.add(sub);
    }
    return subjectList;
  }

  List<Subject> getSubjetList(){
    return [
      Subject(id: '1', userId: userId, name: 'Desarrollo de Aplicaciones Móviles'),
      Subject(id: '2', userId: userId, name: 'Minería de Datos'),
      Subject(id: '3', userId: userId, name: 'Matemáticas Discretas'),
    ];
  }

  void addNewSubject(String subjectName) {
    state = [...state, Subject(
      id: DateTime.now().toString(),
      userId: userId,
      name: subjectName,
    )];

  }


}