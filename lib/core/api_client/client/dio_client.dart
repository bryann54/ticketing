// lib/core/api_client/client/dio_client.dart

import 'package:ticketing/core/api_client/client/loggin_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DioClient {
  final Dio _dio;
  // final String _authToken;

  DioClient(
    Dio dio,
    @Named('BaseUrl') String baseUrl,
    // @Named('AuthToken') this._authToken)
  ) : _dio = dio {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30);

    _dio.interceptors.add(DioLogInterceptors(printBody: kDebugMode));
    // _dio.interceptors.add(AuthInterceptor(_authToken)); // Uncomment and fix _authToken if needed
  }

  Dio getInstance() => _dio;
}
