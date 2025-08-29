// lib/features/auth/data/datasources/auth_remoteDataSource.dart

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/api_client/client/client/api_client.dart';

import 'package:ticketing/core/errors/exceptions.dart';
import 'package:ticketing/features/auth/data/models/user_model.dart';
import 'package:ticketing/common/utils/pkce_generator.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:ticketing/core/api_client/endpoints/api_endpoints.dart';

abstract class AuthRemoteDataSource {
  Stream<UserModel?> get authStateChanges;
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> signUpWithEmailAndPassword(String email, String password,
      String firstName, String lastName, File? profileImage);
  Future<UserModel> signInWithGoogle();
  Future<void> signOut();
  Future<void> resetPassword(String email);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;
  final FlutterSecureStorage _secureStorage;

  AuthRemoteDataSourceImpl(this._apiClient, this._secureStorage);

  static const _googleAuthUrl = 'https://accounts.google.com/o/oauth2/v2/auth';
  static const _clientId =
      '746648352405-79tnhinpfgfu2fji1ub9ghbt2edpol1n.apps.googleusercontent.com';
  static const _redirectUri = 'com.nduko.ticketing:/oauth2redirect';

  @override
  Stream<UserModel?> get authStateChanges async* {
    final token = await _secureStorage.read(key: 'accessToken');
    if (token != null) {
      try {
        final response = await _apiClient.get<Map<String, dynamic>>(
          url: ApiEndpoints.authMe,
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
        url: ApiEndpoints.authSignIn,
        payload: {'email': email, 'password': password},
      );
      final accessToken = response['accessToken'] as String;
      await _secureStorage.write(key: 'accessToken', value: accessToken);
      return UserModel.fromJson(response['user']);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      // Added for completeness
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
        'firstName': firstName,
        'lastName': lastName,
        if (profileImage != null)
          'profileImage': await MultipartFile.fromFile(profileImage.path),
      });

      final response = await _apiClient.post<Map<String, dynamic>>(
        url: ApiEndpoints.authSignUp,
        payload: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      final accessToken = response['accessToken'] as String;
      await _secureStorage.write(key: 'accessToken', value: accessToken);
      return UserModel.fromJson(response['user']);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      // Added for completeness
      throw ClientException(message: e.message);
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final codeVerifier = generateCodeVerifier();
      final codeChallenge = generateCodeChallenge(codeVerifier);

      final authorizationUrl = '$_googleAuthUrl'
          '?client_id=$_clientId'
          '&redirect_uri=$_redirectUri'
          '&response_type=code'
          '&scope=email%20profile'
          '&code_challenge=$codeChallenge'
          '&code_challenge_method=S256';

      final result = await FlutterWebAuth2.authenticate(
        url: authorizationUrl,
        callbackUrlScheme: 'com.nduko.ticketing',
      );

      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) {
        throw  ClientException(
            message: 'Authorization code not received.');
      }

      final response = await _apiClient.post<Map<String, dynamic>>(
        url: ApiEndpoints.authGoogleCallback,
        payload: {
          'code': code,
          'code_verifier': codeVerifier,
          'redirect_uri': _redirectUri,
        },
      );
      final accessToken = response['accessToken'] as String;
      await _secureStorage.write(key: 'accessToken', value: accessToken);
      return UserModel.fromJson(response['user']);
    } on ClientException {
      rethrow;
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ClientException(message: 'Google Sign-In failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _apiClient.post<void>(url: ApiEndpoints.authSignOut);
      await _secureStorage.delete(key: 'accessToken');
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      // Added for completeness
      throw ClientException(message: e.message);
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _apiClient.post<void>(
        url: ApiEndpoints.authResetPassword,
        payload: {'email': email},
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      // Added for completeness
      throw ClientException(message: e.message);
    }
  }
}
