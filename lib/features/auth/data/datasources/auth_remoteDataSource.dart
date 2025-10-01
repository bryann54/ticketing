// lib/features/auth/data/datasources/auth_remoteDataSource.dart

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/api_client/client/api_client.dart';
import 'package:ticketing/core/errors/exceptions.dart';
import 'package:ticketing/features/auth/data/models/user_model.dart';
import 'package:ticketing/core/api_client/endpoints/api_endpoints.dart';

abstract class AuthRemoteDataSource {
  Stream<UserModel?> get authStateChanges;
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> signUpWithEmailAndPassword(String email, String password,
      String firstName, String lastName, File? profileImage);
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<void> changePassword(String currentPassword, String newPassword);
  Future<void> verifyOtp(String email, String otp);
  Future<void> sendOtp(String email);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;
  final FlutterSecureStorage _secureStorage;

  AuthRemoteDataSourceImpl(this._apiClient, this._secureStorage);

  @override
  Stream<UserModel?> get authStateChanges async* {
    final token = await _secureStorage.read(key: 'accessToken');
    if (token != null) {
      try {
        // Use merchants/me endpoint to get current user
        final response = await _apiClient.get<Map<String, dynamic>>(
          url: ApiEndpoints.authMerchantsMe,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        yield UserModel.fromJson(response);
      } on ServerException {
        await _secureStorage.delete(key: 'accessToken');
        yield null;
      } on ClientException {
        yield null;
      } on Exception {
        yield null;
      }
    } else {
      yield null;
    }
  }
@override
Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        url: ApiEndpoints.authLogin,
        payload: {
          'username': email, // API expects 'username' field, not 'email'
          'password': password,
        },
      );

      // Extract token from response - adjust based on actual API response
      final accessToken =
          response['token'] as String? ?? response['access_token'] as String?;

      if (accessToken != null) {
        await _secureStorage.write(key: 'accessToken', value: accessToken);
      }

      // Create user model from response
      return UserModel.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(String email, String password,
      String firstName, String lastName, File? profileImage) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
        // Add other fields if required by your API
        if (firstName.isNotEmpty) 'first_name': firstName,
        if (lastName.isNotEmpty) 'last_name': lastName,
        if (profileImage != null)
          'profile_image': await MultipartFile.fromFile(profileImage.path),
      });

      final response = await _apiClient.post<Map<String, dynamic>>(
        url: ApiEndpoints.authRegister,
        payload: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      // Extract token from response
      final accessToken = response['token'] as String?;

      if (accessToken != null) {
        await _secureStorage.write(key: 'accessToken', value: accessToken);
      }

      // Create user model from response
      return UserModel.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      // Clear local storage only since there's no explicit signout endpoint
      await _secureStorage.delete(key: 'accessToken');
    } on Exception catch (e) {
      throw ClientException(message: 'Sign out failed: ${e.toString()}');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _apiClient.post<void>(
        url: ApiEndpoints
            .authOtp, // Use OTP endpoint for password reset initiation
        payload: {'email': email},
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }

  @override
  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    try {
      await _apiClient.post<void>(
        url: ApiEndpoints.authChangePassword,
        payload: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }

  @override
  Future<void> verifyOtp(String email, String otp) async {
    try {
      await _apiClient.post<void>(
        url: ApiEndpoints.authOtpVerify,
        payload: {'email': email, 'otp': otp},
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }

  @override
  Future<void> sendOtp(String email) async {
    try {
      await _apiClient.post<void>(
        url: ApiEndpoints.authOtp,
        payload: {'email': email},
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }
}
