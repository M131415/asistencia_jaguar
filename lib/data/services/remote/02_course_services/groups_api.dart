import 'dart:developer';

import 'package:asistencia_jaguar/config/endpoints/enpoints.dart';
import 'package:asistencia_jaguar/data/sources/user_prefreferences.dart';
import 'package:dio/dio.dart';

class GroupsService {
  // final Client _client;
  // final _tokenProvider = TokenProvider()
  final Dio _dio = Dio();
  final pref = UserPreferences();

  Options _getOptions() {
    return Options(
      headers: {
        Headers.contentTypeHeader: 'application/json',
        'Authorization': 'Bearer ${pref.token}',
      },
    );
  }

  Future<bool> getAllGroups() async {

    const url = Enpoints.groupsAPI;

    try {
     
      final response = await _dio.get(
        url, 
        options: _getOptions(),
      );
      
      if (response.statusCode == 200) {
        log('Groups fetched successfully.');
        log(response.data.toString());
        return true;
      } else {
        log('Failed to fetch groups: ${response.statusCode}');
        return false;
        
      } 
  } catch (e) {
     log(e.toString());
     return false;
    }
  }
}