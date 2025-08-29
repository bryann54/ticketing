// import 'package:ticketing/core/api_client/models/server_error.dart';
// import 'package:ticketing/core/api_client/client/loggin_interceptor.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:injectable/injectable.dart';

// final dio = Dio(
//   BaseOptions(
//     connectTimeout: const Duration(seconds: 30),
//     receiveTimeout: const Duration(seconds: 30),
//     contentType: Headers.jsonContentType,
//   ),
// );

// // We'll use a sealed class to represent the result of an API call.
// // This is a more robust way to handle success vs. failure.
// sealed class ApiResponse<T> {}

// class Success<T> extends ApiResponse<T> {
//   final T data;
//   Success(this.data);
// }

// class Failure<T> extends ApiResponse<T> {
//   final ServerError error;
//   Failure(this.error);
// }

// @lazySingleton
// class ApiClient {
//   ApiClient(
//     @Named('BaseUrl') String baseUrl,
//     // @Named('AuthToken') String? authToken,
//   ) {
//     dio.options.baseUrl = baseUrl;
//     // Interceptors should be added once during setup.
//     dio.interceptors.add(DioLogInterceptors(printBody: kDebugMode));
//     // dio.interceptors.add(AuthInterceptor(authToken ?? ''));
//   }

//   // Generic request method to reduce code repetition and centralize error handling.
//   Future<ApiResponse<T>> _request<T>(
//     Future<Response<dynamic>> Function() apiCall,
//   ) async {
//     try {
//       final response = await apiCall();
//       return Success(response.data as T);
//     } on DioException catch (error) {
//       return Failure(ServerError.withError(error: error));
//     }
//   }

//   Future<ApiResponse<T>> post<T>({
//     required String url,
//     Map<String, dynamic>? payload,
//   }) async {
//     return _request<T>(() => dio.post(url, data: payload));
//   }

//   Future<ApiResponse<T>> put<T>({
//     required String url,
//     required dynamic
//         payload, // Use dynamic to accommodate different payload types
//     String? id, // Add id for specific resource updates
//   }) async {
//     // If id is provided, construct a URL with the ID
//     final updateUrl = id != null ? '$url/$id' : url;
//     return _request<T>(() => dio.put(updateUrl, data: payload));
//   }

//   Future<ApiResponse<void>> delete({
//     required String url,
//     required String id,
//   }) async {
//     try {
//       await dio.delete('$url/$id');
//       return Success(null);
//     } on DioException catch (error) {
//       return Failure(ServerError.withError(error: error));
//     }
//   }

//   Future<ApiResponse<T>> get<T>({
//     required String url,
//     Map<String, dynamic>? query,
//   }) async {
//     return _request<T>(() => dio.get(url, queryParameters: query));
//   }
// }
