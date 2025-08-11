import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String authToken;

  AuthInterceptor(this.authToken);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add the authorization token as a header, which is standard for Django
    if (authToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    super.onRequest(options, handler);
  }
}
