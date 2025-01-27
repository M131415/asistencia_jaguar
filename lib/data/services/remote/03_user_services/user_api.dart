import 'dart:developer';

import 'package:asistencia_jaguar/config/endpoints/enpoints.dart';
import 'package:asistencia_jaguar/data/either.dart';
import 'package:asistencia_jaguar/data/http_request_failure.dart';
import 'package:asistencia_jaguar/data/models/user_admin.dart';
import 'package:asistencia_jaguar/data/models/user_list.dart';
import 'package:asistencia_jaguar/data/models/user_student.dart';
import 'package:asistencia_jaguar/data/models/user_teacher.dart';
import 'package:asistencia_jaguar/data/services/remote/catch_errors/catch_errors.dart';
import 'package:asistencia_jaguar/data/services/token_provider.dart';
import 'package:asistencia_jaguar/data/typedefs.dart';
import 'package:asistencia_jaguar/domain/entities/user.dart';
import 'package:dio/dio.dart';

typedef UserListFuture        = FutureEither<HttpRequestFailure, List<UserList>>;
typedef UserStudentListFuture = FutureEither<HttpRequestFailure, List<UserStudent>>;
typedef UserRetrieveFuture    = FutureEither<HttpRequestFailure, User>;
typedef UserFuture            = FutureEither<HttpRequestFailure, bool>;

class UserService {

  final _tokenProvider = TokenProvider();
  final _dio = Dio();
  final _url = Enpoints.usersAPI;

  Future<Options> _getOptions() async {
    try {
      final token = await _tokenProvider.getToken();
      return Options(
        headers: {
          Headers.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    } catch (e) {
      final error = cathError(e);
      throw error;
    }
  }
  // Obtener todos los usuarios
  UserListFuture getAllUsers() async {
    try {
      final options = await _getOptions();
      final response = await _dio.get(_url, options: options);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['results'];
        final userList = data.map((json) => UserList.fromJson(json)).toList();
        return Either.right(userList);
      } else {
        return Either.left(HttpRequestFailure.unknown);
      }
    } catch (e) {
      final error = cathError(e);
      return Either.left(error);
    }
  }

  // Obtener todos los usuarios con un rol específico
  UserListFuture getAllUsersByRol(UserRol rol) async {
    try {
      final options = await _getOptions();
      final queryParams = {
        'rol': rol.toJson(),
      };
      final response = await _dio.get(_url, options: options, queryParameters: queryParams);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['results'];
        final userList = data.map((json) => UserList.fromJson(json)).toList();
        return Either.right(userList);
      } else {
        return Either.left(HttpRequestFailure.unknown);
      }
    } catch (e) {
      final error = cathError(e);
      return Either.left(error);
    }
  }

  // Obtener un usuario por su ID
  UserRetrieveFuture getUserById(int id) async {
    try {
      final options = await _getOptions();
      final response = await _dio.get('$_url$id/', options: options);

      if (response.statusCode == 200) {
        final rol = UserRol.fromString(response.data['rol']);
        late User user;
        log('User retrieved successfully.${response.data}');
        if (rol == UserRol.teacher) {
          user = UserTeacher.fromJson(response.data);
        } else if (rol == UserRol.student) {
          user = UserStudent.fromJson(response.data);
        } else{
          user = UserAdmin.fromJson(response.data);
        }
        return Either.right(user);
      } else {
        return Either.left(HttpRequestFailure.unknown);
      }
    } catch (e) {
      final error = cathError(e);
      return Either.left(error);
    }
  }

  // Create a new User
  UserFuture createUser(User user) async {
    try {
      final options = await _getOptions();
      late Json data;
      
      if (user is UserTeacher){
        data = user.toJson();
      } else if (user is UserStudent){
        data = user.toJson();
      } else if (user is UserAdmin){
        data = user.toJson();
      }
      final response = await _dio.post(_url, options: options, data: data,);

      if (response.statusCode == 201) {
        log('SchoolRoom created successfully.');
        return Either.right(true);
      } else {
        return Either.left(HttpRequestFailure.unknown);
      }
    } catch (e) {
      final error = cathError(e);
      return Either.left(error);
    }
  }

  // Create a new List of Users type Student
  UserStudentListFuture createUserStudentList(List<UserStudentCreate> users) async {
    try {
      final options = await _getOptions();
      final data = users.map((user) => user.toJson()).toList();
      final url = '${_url}create_from_list/';
      final response = await _dio.post(url, options: options, data: data);

      if (response.statusCode == 201) {
        log('Todos los usuarios se crearon correctamente.');
        final List<dynamic> data = response.data['created_users'];
        final users = data.map((json) => UserStudent.fromJson(json)).toList();
        return Either.right(users);

      } else if (response.statusCode == 207) {
        final List<dynamic> users = response.data['created_users'];
        if (users.isNotEmpty) {
          log('usuarios creados: $users');
          log(users.toString());
          final userList = users.map((json) => UserStudent.fromJson(json)).toList();
          return Either.right(userList);

        } else {
          final error = response.data['errors'];
          log('Errores al crear usuarios: $error');
          return Either.left(HttpRequestFailure.unknown);

        }
      } else {
        log('Error desconocido ${response.data}');
        return Either.left(HttpRequestFailure.unknown);
      }
    } catch (e) {
      final error = cathError(e);
      return Either.left(error);
    }
  }

  // Update an existing User
  UserFuture updateUser(int id, User user) async {
    try {

      final options = await _getOptions();
      late Json data;
      
      if (user is UserTeacher){
        data = user.toJson();
      } else if (user is UserStudent){
        data = user.toJson();
      } else if (user is UserAdmin){
        data = user.toJson();
      }

      final response = await _dio.put('$_url$id/', options: options, data: data);

      if (response.statusCode == 200) {
        log('SchoolRoom updated successfully.');
        return Either.right(true);
      } else {
        log('Failed to update SchoolRoom: ${response.statusCode}');
        return Either.left(HttpRequestFailure.unknown);
      }
    } catch (e) {
      final error = cathError(e);
      return Either.left(error);
    }
  }

  // Delete a user
  UserFuture deleteUser(int id) async {
    try {
      final options = await _getOptions();
      final response = await _dio.delete('$_url$id/', options: options);

      if (response.statusCode == 200) {
        log('User deleted successfully.');
        return Either.right(true);
      } else {
        log('Failed to delete User: ${response.statusCode}');
        return Either.left(HttpRequestFailure.unknown);
      }
    } catch (e) {
      final error = cathError(e);
      return Either.left(error);
    }
  }
}
