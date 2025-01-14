import 'dart:developer';

import 'package:asistencia_jaguar/config/endpoints/enpoints.dart';
import 'package:asistencia_jaguar/data/either.dart';
import 'package:asistencia_jaguar/data/http_request_failure.dart';
import 'package:asistencia_jaguar/data/models/school_room_model.dart';
import 'package:asistencia_jaguar/data/services/remote/catch_errors/catch_errors.dart';
import 'package:asistencia_jaguar/data/services/token_provider.dart';
import 'package:asistencia_jaguar/data/typedefs.dart';
import 'package:dio/dio.dart';

typedef SchoolRoomListFuture = FutureEither<HttpRequestFailure, List<SchoolRoomModel>>;
typedef SchoolRoomFuture = FutureEither<HttpRequestFailure, bool>;

class SchoolRoomService {

  final _tokenProvider = TokenProvider();
  final _dio = Dio();
  final _url = Enpoints.schoolRoomsAPI;

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

  SchoolRoomListFuture getAllSchoolRooms() async {
    try {
      final options = await _getOptions();
      final response = await _dio.get(_url, options: options);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['results'];
        final schoolRoomList = data.map((json) => SchoolRoomModel.fromJson(json)).toList();
        return Either.right(schoolRoomList);
      } else {
        return Either.left(HttpRequestFailure.unknown);
      }
    } catch (e) {
      final error = cathError(e);
      return Either.left(error);
    }
  }

  // Create a new SchoolRoom
  SchoolRoomFuture createSchoolRoom(SchoolRoomModel schoolRoomModel) async {
    try {
      final options = await _getOptions();
      final response = await _dio.post(_url, options: options, data: schoolRoomModel.toJson(),);

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

  // Update an existing SchoolRoom
  SchoolRoomFuture updateSchoolRoom(int id, SchoolRoomModel schoolRoom) async {
    try {

      final options = await _getOptions();
      final response = await _dio.put('$_url$id/', options: options, data: schoolRoom.toJson());

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

  // Delete a SchoolRoom
  SchoolRoomFuture deleteSchoolRoom(int id) async {
    try {
      final options = await _getOptions();
      final response = await _dio.delete('$_url$id/', options: options);

      if (response.statusCode == 200) {
        log('SchoolRoomModel deleted successfully.');
        return Either.right(true);
      } else {
        log('Failed to delete SchoolRoom: ${response.statusCode}');
        return Either.left(HttpRequestFailure.unknown);
      }
    } catch (e) {
      final error = cathError(e);
      return Either.left(error);
    }
  }
}
