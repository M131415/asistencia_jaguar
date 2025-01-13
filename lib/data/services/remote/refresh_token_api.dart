import 'package:asistencia_jaguar/config/endpoints/enpoints.dart';
import 'package:dio/dio.dart';

class RefreshTokenService {

  final _dio = Dio();
  final options = Options(
      headers: {
        Headers.contentTypeHeader: 'application/json',
      },
    );
  
  Future<String> refreshToken(String refreshToken) async {
    const url = Enpoints.refreshToken;

    try {
      final response = await _dio.post(
        url,
        data: {
          'refresh': refreshToken,
        },
        options: options,
      );

      if (response.statusCode == 200) {
        return response.data['access'] as String;
      }
      return '';
    } catch (e) {
      return '';
    }
  }
}