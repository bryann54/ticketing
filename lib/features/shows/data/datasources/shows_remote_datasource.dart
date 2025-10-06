// lib/features/shows/data/datasources/shows_remote_datasource.dart

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ticketing/core/api_client/client/api_client.dart';
import 'package:ticketing/core/api_client/endpoints/api_endpoints.dart';
import 'package:ticketing/core/errors/exceptions.dart';
import 'package:ticketing/features/shows/data/models/get_shows_query_model.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ShowsRemoteDatasource {
  final ApiClient _client;
  final FlutterSecureStorage _secureStorage;

  ShowsRemoteDatasource(this._client, this._secureStorage);

  Future<Options> _getAuthOptions() async {
    final token = await _secureStorage.read(key: 'accessToken');
    if (token == null || token.isEmpty) {
      throw ClientException(message: 'No authentication token found');
    }
    return Options(
      headers: {
        'Authorization':
            'Token $token', // Django REST Framework uses 'Token' prefix
      },
    );
  }

  Future<List<ShowModel>> getShows(GetShowsQueryModel query) async {
    final options = await _getAuthOptions();

    // API returns paginated response: {payload: [...], totalPages: 1, ...}
    final response = await _client.get<Map<String, dynamic>>(
      url: ApiEndpoints.showsAll,
      query: query.toJson(),
      options: options,
    );

    // Extract the shows array from the "payload" field
    final payload = response['payload'] as List<dynamic>;

    final List<ShowModel> shows = payload
        .map((item) => ShowModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return shows;
  }

  Future<ShowModel> createShow(ShowModel show) async {
    final options = await _getAuthOptions();

    final response = await _client.post<Map<String, dynamic>>(
      url: ApiEndpoints.showsAll,
      payload: show.toJson(),
      options: options,
    );

    return ShowModel.fromJson(response);
  }

  Future<ShowModel> editShow(ShowModel show) async {
    final options = await _getAuthOptions();

    final url = '${ApiEndpoints.showsAll}${show.id}/';

    final response = await _client.put<Map<String, dynamic>>(
      url: url,
      payload: show.toJson(),
      options: options,
    );

    return ShowModel.fromJson(response);
  }

  Future<void> deleteShow(String showId) async {
    final options = await _getAuthOptions();

    final url = '${ApiEndpoints.showsAll}$showId/';

    await _client.delete(
      url: url,
      options: options,
    );
  }
}
