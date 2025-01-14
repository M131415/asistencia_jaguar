import 'dart:developer';

import 'package:asistencia_jaguar/data/http_request_failure.dart';
import 'package:asistencia_jaguar/data/models/school_room_model.dart';
import 'package:asistencia_jaguar/data/services/remote/02_course_services/school_room_api.dart';
import 'package:asistencia_jaguar/data/typedefs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'school_room_provider.g.dart';

typedef SchoolRoomFuture = FutureEither<HttpRequestFailure, SchoolRoomModel>;

@riverpod
class SchoolRoomState extends _$SchoolRoomState {
  final _schoolRoomService = SchoolRoomService();

  @override
  FutureOr<List<SchoolRoomModel>> build() async {
    final response = await _schoolRoomService.getAllSchoolRooms();
    return response.when(
      left: (failure) => throw Exception(failure.message),
      right: (schoolRooms) => schoolRooms,
    );
  }

  Future<bool> createSchoolRoom(SchoolRoomModel schoolRoom) async {
    state = const AsyncLoading();
    final result = await _schoolRoomService.createSchoolRoom(schoolRoom);
    return result.when(
      left: (failure) {
        log('Error creating school room: ${failure.message}');
        return false;
      },
      right: (_) {
        ref.invalidateSelf();
        return true;
      },
    );
  }

  Future<bool> updateSchoolRoom(int id, SchoolRoomModel schoolRoom) async {
    state = const AsyncLoading();
    final result = await _schoolRoomService.updateSchoolRoom(id, schoolRoom);
    return result.when(
      left: (failure) {
        log('Error updating school room: ${failure.message}');
        return false;
      },
      right: (_) {
        ref.invalidateSelf();
        return true;
      },
    );
  }

  Future<bool> deleteSchoolRoom(int id) async {
    state = const AsyncLoading();
    final result = await _schoolRoomService.deleteSchoolRoom(id);
    return result.when(
      left: (failure) {
        log('Error deleting school room: ${failure.message}');
        return false;
      },
      right: (_) {
        ref.invalidateSelf();
        return true;
      },
    );
  }
}