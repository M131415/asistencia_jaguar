import 'dart:convert';
import 'dart:io';

import 'package:asistencia_jaguar/data/models/user_student.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'student_list.g.dart';

@riverpod
class StudentList extends _$StudentList {

  final List<UserStudent> studentList = [];

  late List<UserStudent> studentListFromCSV = [];

  @override
  List<UserStudent> build() {
    for (UserStudent sub in getStudentList()){
      studentList.add(sub);
    }
    return studentList;
  }

  // The response of the `GET /api/students` endpoint.
  List<UserStudent> getStudentList(){
    return [];
  }

  /*  Agrega una Estudiantes a partir de una lista obtenida
      desde un archivo CSV  */
  void onAddStudentfromList() async {

    studentListFromCSV = await ref.watch(
      getStudentsFromCSVProvider(studentListFromCSV).future
    );

    if (studentListFromCSV.isNotEmpty){
      for (var student in studentListFromCSV) {
        state = [...state, student];
      }
    }
    return;
  }
}

/*  Esta funcion provider solo accede a archivos CSV para leerlo y obtener
    el valor de las columnas para convertirla 
    en una lista de entidades de Estudiantes  */
@riverpod
FutureOr<List<UserStudent>> getStudentsFromCSV(GetStudentsFromCSVRef ref, List<UserStudent> studentList) async {

  String? filePath;

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    type: FileType.custom,
    allowedExtensions: ['csv'],
  );

  if (result != null) { 
    filePath = result.files.single.path!; 
    final input = File(filePath).openRead(); 
    final fieldList = await input .transform(utf8.decoder) .transform(const CsvToListConverter()) .toList(); 
    
    studentList = UserStudent.fromCsvTable(fieldList);

    return studentList;

  } return [];
  
}