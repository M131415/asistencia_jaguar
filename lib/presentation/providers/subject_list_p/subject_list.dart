import 'package:asistencia_jaguar/domain/entities/subject_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subject_list.g.dart';

@riverpod
class SubjectList extends _$SubjectList {

  List<SubjectEntity> subjectList = [];
  String userId = '1';

  @override
  List<SubjectEntity> build() {
    for (SubjectEntity sub in getSubjetList()){
      subjectList.add(sub);
    }
    return subjectList;
  }

  List<SubjectEntity> getSubjetList(){
    return [
      SubjectEntity(id: '1', userId: userId, name: 'Desarrollo de Aplicaciones Móviles'),
      SubjectEntity(id: '2', userId: userId, name: 'Minería de Datos'),
      SubjectEntity(id: '3', userId: userId, name: 'Matemáticas Discretas'),
    ];
  }

  void addNewSubject(String subjectName) {
    state = [...state, SubjectEntity(
      id: DateTime.now().toString(),
      userId: userId,
      name: subjectName,
    )];

  }


}