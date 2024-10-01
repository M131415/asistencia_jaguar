import 'package:asistencia_jaguar/domain/entities/subject_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_subject.g.dart';

@riverpod
class SelectedSubject extends _$SelectedSubject {

  final SubjectEntity selectedSubjet = SubjectEntity(id: '', userId: '', name: '');
  
  @override
  SubjectEntity build() {
    return selectedSubjet;
  }

  void onSelectSubject(SubjectEntity sub){
    state = sub;
  }
}