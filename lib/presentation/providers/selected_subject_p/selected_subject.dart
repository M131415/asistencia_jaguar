import 'package:asistencia_jaguar/domain/entities/subject.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_subject.g.dart';

@riverpod
class SelectedSubject extends _$SelectedSubject {

  final Subject selectedSubjet = Subject(id: '', userId: '', name: '');
  
  @override
  Subject build() {
    return selectedSubjet;
  }

  void onSelectSubject(Subject sub){
    state = sub;
  }
}