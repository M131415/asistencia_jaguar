import 'dart:developer';

import 'package:asistencia_jaguar/config/config.dart';
import 'package:asistencia_jaguar/config/endpoints/enpoints.dart';
import 'package:asistencia_jaguar/data/either.dart';
import 'package:asistencia_jaguar/data/http_request_failure.dart';
import 'package:asistencia_jaguar/data/models/login_model.dart';
import 'package:asistencia_jaguar/data/sources/user_prefreferences.dart';
import 'package:asistencia_jaguar/data/typedefs.dart';
import 'package:asistencia_jaguar/domain/entities/user.dart';
import 'package:dio/dio.dart';

typedef LoginFuture = FutureEither<HttpRequestFailure, LoginModel>;

class LoginService {
  // final Client _client;
  // final _tokenProvider = TokenProvider()
  final Dio _dio = Dio();
  final options = Options(
      headers: {
        Headers.contentTypeHeader: 'application/json',
      },
    );

  LoginFuture authenticate(String username, String password) async {
    
    const url = Enpoints.login;

    try {
      final response = await _dio.post(
        url, 
        data: {
          'username': username,
          'password': password
        },
        options: options
      );

      if (response.statusCode == 200) {
        final login = LoginModel.fromJson(response.data);
        log(login.toString());
        _saveLoginData(login);
        return Either.right(login);
      }
      return Either.left(HttpRequestFailure.unknown);
    } catch (e) {
      log('Error en autentucate: $e');
      late HttpRequestFailure failure;
      if (e is DioException) {
        // Aquí manejamos los status codes de error
        final statusCode = e.response?.statusCode;
        final message = e.response?.statusMessage;
        log('Dio Error fetching careers: $message');
        if (statusCode != null) {
          for (final status in HttpRequestFailure.values) {
            if (statusCode == status.statusCode) {
              return Either.left(status);
            }
          }
        }
        failure = HttpRequestFailure.local;
      } else {
        failure = HttpRequestFailure.local;
      }
      return Either.left(failure);
    }
  }

  bool _saveLoginData(LoginModel login) {
    final pref = UserPreferences();

    try {
      pref.token = login.token;
      pref.refreshToken = login.refreshToken;
      pref.saveUser(login.user);
      _saveDefaultRouteByRol(login.user.rol, pref);
      log('Login data saved');
      return true;
    } catch (e) {
      log('Error saving login data: $e');
      return false;
    }
  }

  void _saveDefaultRouteByRol(UserRol rol, UserPreferences pref) {
    final Routes defaultRoute;
    switch (rol) {
      case UserRol.admin:
        defaultRoute = Routes.adminHome;
        break;
      case UserRol.teacher:
        defaultRoute = Routes.teacherHome;
        break;
      case UserRol.student:
        defaultRoute = Routes.studentHome;
        break;
      default:
        defaultRoute = Routes.login;
    }
    pref.defaultRoute = defaultRoute.getPath();
    log('Default route saved: ${pref.defaultRoute}');
  }
}