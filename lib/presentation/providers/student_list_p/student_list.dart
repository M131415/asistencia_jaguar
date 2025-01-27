import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:asistencia_jaguar/data/models/user_student.dart';
import 'package:asistencia_jaguar/data/services/remote/03_user_services/user_api.dart';
import 'package:asistencia_jaguar/domain/entities/user.dart';
import 'package:asistencia_jaguar/presentation/providers/user_p/user_provider.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'student_list.g.dart';

@riverpod
class StudentList extends _$StudentList {

  final _userService = UserService();

  final List<User> studentListFromCSV = [];

  @override
  List<User> build() {
    return studentListFromCSV;
  }

   // Create user list type student
  Future<bool> createUserStudentList(List<User> users) async {
    try{
      if (users.every((user) => user is UserStudentCreate)) {
        final userStudentList = users.cast<UserStudentCreate>();
        final response = await _userService.createUserStudentList(userStudentList);
        return response.when(
          left: (failure) => throw Exception(failure.message),
          right: (userList) {
            state = [
              for (final existing in state)
                if (!userList.any((u) => u.username == existing.username)) existing
            ];
            state = [...userList, ...state];

            // Actualizar la lista de los usuarios
            ref.read(userNotifierProvider.notifier).getAllUsers();
            return true;
          }
        );
      } else {
        return false;
      }
    } catch (e) {
      log('Error al crear la lista de estudiantes: $e');
      return false;
    }
  }

  /*  Agrega una Estudiantes a partir de una lista obtenida
      desde un archivo CSV  */
  Future<bool> uploadCSV() async {
    final students = await getStudentsFromCSV();
    if (students.isNotEmpty) {
      state = [...state, ...students];
      log('Estudiantes cargados: ${students.length}');
      return true;
    } else {
      return false;
    }
}

/*  Esta funcion provider solo accede a archivos CSV para leerlo y obtener
    el valor de las columnas para convertirla 
    en una lista de entidades de Estudiantes  */
FutureOr<List<UserStudentCreate>> getStudentsFromCSV() async {

  String? filePath;

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    type: FileType.custom,
    allowedExtensions: ['csv'],
    withData: true,
  );

  if (result != null) { 
    try{
      filePath = result.files.single.path!; 
      final input = File(filePath).openRead(); 
      final fieldList = await input .transform(utf8.decoder) .transform(const CsvToListConverter()) .toList(); 
      
      final studentList = UserStudentCreate.fromCsvTable(fieldList);
      return studentList;
    } catch (e) {
      log('Error al cargar el archivo CSV: $e');
      return [];
    }

  } return [];
  
}
}