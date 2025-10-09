// lib/features/merchant/data/datasources/merchant_remote_datasource.dart

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/api_client/client/api_client.dart';
import 'package:ticketing/core/api_client/endpoints/api_endpoints.dart';
import 'package:ticketing/core/errors/exceptions.dart';
import 'package:ticketing/features/merchant/data/models/merchant_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class MerchantRemoteDatasource {
  Future<MerchantModel> createMerchant({
    required String name,
    required String businessEmail,
    required String businessTelephone,
  });

  Future<MerchantModel> getMerchantDetails();
  Future<MerchantModel> updateMerchant({
    required String name,
    required String businessEmail,
    required String businessTelephone,
  });
}

@LazySingleton(as: MerchantRemoteDatasource)
class MerchantRemoteDatasourceImpl implements MerchantRemoteDatasource {
  final ApiClient _client;
  final FlutterSecureStorage _secureStorage;

  MerchantRemoteDatasourceImpl(this._client, this._secureStorage);

  @override
  Future<MerchantModel> createMerchant({
    required String name,
    required String businessEmail,
    required String businessTelephone,
  }) async {
    try {
      final accessToken = await _secureStorage.read(key: 'accessToken');
      if (accessToken == null) {
        throw ClientException(
            message: 'Not authenticated. Please log in again.');
      }

      final response = await _client.post<Map<String, dynamic>>(
        url: ApiEndpoints.authMerchantsCreate,
        payload: {
          'name': name,
          'email': businessEmail,
          'phone_number': businessTelephone,
        },
        options: Options(
          headers: {
            'Authorization': 'Token $accessToken',
          },
        ),
      );

      return MerchantModel.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }
@override
Future<MerchantModel> updateMerchant({
  required String name,
  required String businessEmail,
  required String businessTelephone,
}) async {
  try {
    final accessToken = await _secureStorage.read(key: 'accessToken');
    if (accessToken == null) {
      throw ClientException(
          message: 'Not authenticated. Please log in again.');
    }

    final response = await _client.put<Map<String, dynamic>>(
      url: ApiEndpoints.authMerchantsUpdate,
      payload: {
        'name': name,
        'email': businessEmail,
        'phone_number': businessTelephone,
      },
      options: Options(
        headers: {
          'Authorization': 'Token $accessToken',
        },
      ),
    );

    return MerchantModel.fromJson(response);
  } on ServerException catch (e) {
    throw ServerException(message: e.message, statusCode: e.statusCode);
  } on ClientException catch (e) {
    throw ClientException(message: e.message);
  }
}
  @override
  Future<MerchantModel> getMerchantDetails() async {
    try {
      final accessToken = await _secureStorage.read(key: 'accessToken');
      if (accessToken == null) {
        throw ClientException(
            message: 'Not authenticated. Please log in again.');
      }

      final response = await _client.get<Map<String, dynamic>>(
        url: ApiEndpoints.authMerchantsMe,
        options: Options(
          headers: {
            'Authorization': 'Token $accessToken',
          },
        ),
      );

      return MerchantModel.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }
}
