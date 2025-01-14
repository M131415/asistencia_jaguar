// Provider para gestionar las carreras

import 'dart:developer';

import 'package:asistencia_jaguar/data/models/career_model.dart';
import 'package:asistencia_jaguar/data/services/remote/02_course_services/career_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'career_provider.g.dart';

@riverpod
class CareerState extends _$CareerState {
  final _careerService = CareerService();

  @override
  FutureOr<List<CareerModel>> build() async {
    final response = await _careerService.getAllCareers();
    return response.when(
      left: (failure) => throw Exception(failure.message),
      right: (careers) => careers,
    );
  }

  Future<bool> createCareer(CareerModel career) async {
    state = const AsyncLoading();
    final result = await _careerService.createCareer(career);
    return result.when(
      left: (failure) {
        log('Error creating career: ${failure.message}');
        return false;
      },
      right: (_) {
        ref.invalidateSelf();
        return true;
      },
    );
  }

  Future<bool> updateCareer(int id, CareerModel career) async {
    state = const AsyncLoading();
    final result = await _careerService.updateCareer(id, career);
    return result.when(
      left: (failure) {
        log('Error updating career: ${failure.message}');
        return false;
      },
      right: (_) {
        ref.invalidateSelf();
        return true;
      },
    );
  }

  Future<bool> deleteCareer(int id) async {
    state = const AsyncLoading();
    final result = await _careerService.deleteCareer(id);
    return result.when(
      left: (failure) {
        log('Error deleting career: ${failure.message}');
        return false;
      },
      right: (_) {
        ref.invalidateSelf();
        return true;
      },
    );
  }
}