import 'dart:developer';

import 'package:asistencia_jaguar/config/endpoints/enpoints.dart';
import 'package:asistencia_jaguar/data/either.dart';
import 'package:asistencia_jaguar/data/http_request_failure.dart';
import 'package:asistencia_jaguar/data/models/career_model.dart';
import 'package:asistencia_jaguar/data/services/remote/catch_errors/catch_errors.dart';
import 'package:asistencia_jaguar/data/services/token_provider.dart';
import 'package:asistencia_jaguar/data/typedefs.dart';
import 'package:dio/dio.dart';

typedef CareerListFuture = FutureEither<HttpRequestFailure, List<CareerModel>>;
typedef CareerRetrieveFuture = FutureEither<HttpRequestFailure, CareerModel>;
typedef CareerFuture = FutureEither<HttpRequestFailure, bool>;

class CareerService {

  final _tokenProvider = TokenProvider();
  final _dio = Dio();
  final _url = Enpoints.careersAPI;

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

  CareerListFuture getAllCareers() async {
    try {
      final options = await _getOptions();
      final response = await _dio.get(_url, options: options);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['results'];
        final careerList = data.map((json) => CareerModel.fromJson(json)).toList();
        return Either.right(careerList);
      } else {
        return Either.left(HttpRequestFailure.unknown);
      }
    } catch (e) {
      final error = cathError(e);
      return Either.left(error);
    }
  }

  // Get a Career by id
  CareerRetrieveFuture getCareerById(int id) async {
    try {
      final options = await _getOptions();
      final response = await _dio.get('$_url$id/', options: options);

      if (response.statusCode == 200) {
        final career = CareerModel.fromJson(response.data);
        return Either.right(career);
      } else {
        return Either.left(HttpRequestFailure.unknown);
      }
    } catch (e) {
      final error = cathError(e);
      return Either.left(error);
    }
  }

  // Create a new Career
  CareerFuture createCareer(CareerModel career) async {
    try {
      final options = await _getOptions();
      final response = await _dio.post(_url, options: options, data: career.toJson(),);

      if (response.statusCode == 201) {
        log('Career created successfully.');
        return Either.right(true);
      } else {
        return Either.left(HttpRequestFailure.unknown);
      }
    } catch (e) {
      final error = cathError(e);
      return Either.left(error);
    }
  }

  // Update an existing Career
  CareerFuture updateCareer(int id, CareerModel career) async {
    try {

      final options = await _getOptions();
      final response = await _dio.put('$_url$id/', options: options, data: career.toJson());

      if (response.statusCode == 200) {
        log('Career updated successfully.');
        return Either.right(true);
      } else {
        log('Failed to update career: ${response.statusCode}');
        return Either.left(HttpRequestFailure.unknown);
      }
    } catch (e) {
      final error = cathError(e);
      return Either.left(error);
    }
  }

  // Delete a Career
  CareerFuture deleteCareer(int id) async {
    try {
      final options = await _getOptions();
      final response = await _dio.delete('$_url$id/', options: options);

      if (response.statusCode == 204) {
        log('Career deleted successfully.');
        return Either.right(true);
      } else {
        log('Failed to delete career: ${response.statusCode}');
        return Either.left(HttpRequestFailure.unknown);
      }
    } catch (e) {
      final error = cathError(e);
      return Either.left(error);
    }
  }
}
