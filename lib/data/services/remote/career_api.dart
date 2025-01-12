import 'dart:developer';

import 'package:asistencia_jaguar/config/endpoints/enpoints.dart';
import 'package:asistencia_jaguar/data/models/career_model.dart';
import 'package:dio/dio.dart';
//import 'package:http/http.dart';

class CareerService {
  // final Client _client;
  // final _tokenProvider = TokenProvider()
  final Dio _dio = Dio();
  final options = Options(
      headers: {
        Headers.contentTypeHeader: 'application/json',
      },
    );

  Future<List<CareerModel>> getAllCareers() async {
    

    const url = Enpoints.careersAPI;

    try {
      final response = await _dio.get(url, options: options);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['results']; 
        return data.map((json) => CareerModel.fromJson(json)).toList();
      } else {
        log('Failed to fetch careers: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching careers: $e');
      return [];
    }
  }

  // Create a new Career
  Future<bool> createCareer(CareerModel career) async {

    const url = Enpoints.careersAPI;

    try {
      final response = await _dio.post(
        url,
        options: options,
        data: career.toJson(),
      );

      if (response.statusCode == 201) {
        log('Career created successfully.');
        return true;
      } else {
        log('Failed to create career: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error creating career: $e');
      return false;
    }
  }

  // Update an existing Career
  Future<bool> updateCareer(int id, CareerModel career) async {

    final url = '${Enpoints.careersAPI}$id/';

    try {
      final response = await _dio.put(
        url,
        options: options,
        data: career.toJson(),
      );

      if (response.statusCode == 200) {
        log('Career updated successfully.');
        return true;
      } else {
        log('Failed to update career: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error updating career: $e');
      return false;
    }
  }

  // Delete a Career
  Future<bool> deleteCareer(int id) async {

    final url = '${Enpoints.careersAPI}$id/';

    try {
      final response = await _dio.delete(
        url,
        options: options,
      );

      if (response.statusCode == 204) {
        log('Career deleted successfully.');
        return true;
      } else {
        log('Failed to delete career: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error deleting career: $e');
      return false;
    }
  }
}
