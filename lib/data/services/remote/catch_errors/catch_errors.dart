import 'dart:developer';

import 'package:asistencia_jaguar/data/http_request_failure.dart';
import 'package:dio/dio.dart';

HttpRequestFailure cathError(dynamic e) {
    log('Errores desde catchError: ${e.runtimeType}');
    late HttpRequestFailure failure;
    if (e is DioException) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null) {
        for (final status in HttpRequestFailure.values) {
          if (statusCode == status.statusCode) {
            return status;
          }
        }
      }
      failure = HttpRequestFailure.network;
    } else if (e is HttpRequestFailure) {
      failure = e;
      log(failure.statusCode.toString());
    } else {
      failure = HttpRequestFailure.unknown;
    }
    return failure;
  }