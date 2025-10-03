// lib/features/merchant/data/datasources/mpesa_remote_datasource.dart

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/api_client/client/api_client.dart';
import 'package:ticketing/core/api_client/endpoints/api_endpoints.dart';
import 'package:ticketing/core/errors/exceptions.dart';
import 'package:ticketing/features/merchant/data/models/mpesa_details_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class MpesaRemoteDatasource {
  Future<void> addMpesaDetails({
    required String consumerKey,
    required String consumerSecret,
    required String shortCode,
    required String passKey,
    required String integrationType,
    required String partyB,
  });
}

@LazySingleton(as: MpesaRemoteDatasource)
class MpesaRemoteDatasourceImpl implements MpesaRemoteDatasource {
  final ApiClient _client;
  final FlutterSecureStorage _secureStorage;

  MpesaRemoteDatasourceImpl(this._client, this._secureStorage);

  @override
  Future<void> addMpesaDetails({
    required String consumerKey,
    required String consumerSecret,
    required String shortCode,
    required String passKey,
    required String integrationType,
    required String partyB,
  }) async {
    try {
      // Get the access token from secure storage
      final accessToken = await _secureStorage.read(key: 'accessToken');

      if (accessToken == null) {
        throw ClientException(
            message: 'Not authenticated. Please log in again.');
      }

      final mpesaDetails = MpesaDetailsModel(
        consumerKey: consumerKey,
        consumerSecret: consumerSecret,
        shortCode: shortCode,
        passKey: passKey,
        integrationType: integrationType,
        partyB: partyB,
      );

      await _client.post<Map<String, dynamic>>(
        url: ApiEndpoints.authMerchantsDarajaCreate,
        payload: mpesaDetails.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Token $accessToken',
          },
        ),
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }
}
