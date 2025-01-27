import 'dart:convert';
import 'dart:developer';

import 'package:asistencia_jaguar/data/http_request_failure.dart';
import 'package:asistencia_jaguar/data/services/remote/01_auth_services/refresh_token_api.dart';
import 'package:asistencia_jaguar/data/sources/user_prefreferences.dart';

class TokenProvider {

  final _prefs = UserPreferences();

  // metodo para obtener el token 
  Future<String> getToken() async{
   
    final token = _prefs.token;
    if (token.isEmpty) {
      throw HttpRequestFailure.local;
    }
      
    try {
      DateTime expirationDate = _getExpirationDate(token);
      log('Fecha de expiracion del token: ${expirationDate.toString()}');
      // log('Fecha actual: ${DateTime.now().toString()}');
      // log(expirationDate.isBefore(DateTime.now()).toString());
      if (expirationDate.isBefore(DateTime.now())) {
        // Esperar el nuevo token
        final newToken = await _refreshToken();
        log('Nuevo token creado: $newToken');
        _prefs.token = newToken;
        return newToken;
      }
      return token;
    } catch (e) {
      log('Error al procesar token: $e');
      throw HttpRequestFailure.unauthorized;
    }
  }

  // metodo para refrescar el token
  Future<String> _refreshToken() async {
    final refreshToken = _getRefreshToken();
    final refreshTokenService = RefreshTokenService();
    final newToken = await refreshTokenService.refreshToken(refreshToken);
    if (newToken.isEmpty) {
      throw HttpRequestFailure.local;
    }
    return newToken;
  }

  // metodo para obtener el refresh token
  String _getRefreshToken() {
    final refreshToken = _prefs.refreshToken;
    if (refreshToken.isEmpty) {
      throw HttpRequestFailure.local;
    }
    DateTime expirationDate = _getExpirationDate(refreshToken);
    if (expirationDate.isBefore(DateTime.now())) {
      throw HttpRequestFailure.unauthorized;
    }
    return refreshToken;
  }

  // metodo para obtener la fecha de expiracion del token
  DateTime _getExpirationDate(String token) {
    try {
      // Decodificar token JWT
      final parts = token.split('.');
      if (parts.length != 3) {
        throw HttpRequestFailure.local;
      }

      // Decodificar payload (segunda parte del token)
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final Map<String, dynamic> decodedPayload = json.decode(decoded);

      // Extraer exp claim
      final exp = decodedPayload['exp'];
      if (exp == null) {
        throw HttpRequestFailure.local;
      }

      // Convertir timestamp a DateTime
      return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    } catch (e) {
      log('Error decodificando token: $e');
      throw HttpRequestFailure.local;
    }
  }
}