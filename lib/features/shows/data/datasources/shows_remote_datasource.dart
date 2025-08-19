// lib/features/shows/data/datasources/shows_remote_datasource.dart

import 'package:ticketing/core/api_client/client_provider.dart';
import 'package:ticketing/core/api_client/endpoints/api_endpoints.dart';
import 'package:ticketing/core/api_client/models/server_error.dart';
import 'package:ticketing/features/shows/data/models/get_shows_query_model.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ShowsRemoteDatasource {
  final ApiClient _client;

  ShowsRemoteDatasource(this._client);

  Future<ApiResponse<List<ShowModel>>> getShows(
      GetShowsQueryModel query) async {
    final response = await _client.get<List<dynamic>>(
      url: ApiEndpoints.showsAll,
      query: query.toJson(),
    );

    if (response is Success<List<dynamic>>) {
      final List<ShowModel> shows = response.data
          .map((item) => ShowModel.fromJson(item as Map<String, dynamic>))
          .toList();
      return Success(shows);
    } else if (response is Failure) {
      return Failure(ServerError());
    }

    return Failure(ServerError());
  }

  // New method to create a show
  Future<ApiResponse<ShowModel>> createShow(ShowModel show) async {
    final response = await _client.post<Map<String, dynamic>>(
      url: ApiEndpoints.showsAll,
      payload: show.toJson(),
    );

    if (response is Success<Map<String, dynamic>>) {
      return Success(ShowModel.fromJson(response.data));
    } else if (response is Failure) {
      return Failure(ServerError());
    }

    return Failure(ServerError());
  }

  // New method to edit a show
  Future<ApiResponse<ShowModel>> editShow(ShowModel show) async {
    final response = await _client.put<Map<String, dynamic>>(
      url: ApiEndpoints.showsAll, // Assuming the URL is something like /shows
      id: show.id.toString(), // Pass the show ID to the URL
      payload: show.toJson(),
    );

    if (response is Success<Map<String, dynamic>>) {
      return Success(ShowModel.fromJson(response.data));
    } else if (response is Failure) {
      return Failure(ServerError());
    }
    return Failure(ServerError());
  }

  // New method to delete a show
  Future<ApiResponse<void>> deleteShow(String showId) async {
    final response = await _client.delete(
      url: ApiEndpoints.showsAll,
      id: showId,
    );

    if (response is Success) {
      return Success(null);
    } else if (response is Failure) {
      return Failure(ServerError());
    }

    return Failure(ServerError());
  }
}
