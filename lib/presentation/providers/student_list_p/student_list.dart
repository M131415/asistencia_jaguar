import 'dart:convert';
import 'dart:io';

import 'package:asistencia_jaguar/domain/entities.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'student_list.g.dart';

@riverpod
class StudentList extends _$StudentList {

  final List<StudentEntity> studentList = [];

  late List<StudentEntity> studentListFromCSV = [];

  @override
  List<StudentEntity> build() {
    for (StudentEntity sub in getStudentList()){
      studentList.add(sub);
    }
    return studentList;
  }

  // The response of the `GET /api/students` endpoint.
  List<StudentEntity> getStudentList(){
    return [
      StudentEntity.fromMap({
        'id': '1',
        'userId': '1',
        'controlNo': '19520555',
        'name': 'Mauricio Emilio Medina Cedillo',
      }),
    ];
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
FutureOr<List<StudentEntity>> getStudentsFromCSV(GetStudentsFromCSVRef ref, List<StudentEntity> studentList) async {

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
    
    studentList = StudentEntity.fromCsvTable(fieldList);

    return studentList;

  } return [];
  
}