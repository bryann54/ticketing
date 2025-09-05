// lib/features/shows/data/datasources/shows_remote_datasource.dart

import 'package:ticketing/core/api_client/client/api_client.dart';
import 'package:ticketing/core/api_client/endpoints/api_endpoints.dart';
import 'package:ticketing/features/shows/data/models/get_shows_query_model.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ShowsRemoteDatasource {
  final ApiClient _client;

  ShowsRemoteDatasource(this._client);

  Future<List<ShowModel>> getShows(GetShowsQueryModel query) async {
    final response = await _client.get<List<dynamic>>(
      url: ApiEndpoints.showsAll,
      query: query.toJson(),
    );

    final List<ShowModel> shows = response
        .map((item) => ShowModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return shows;
  }

  Future<ShowModel> createShow(ShowModel show) async {
    final response = await _client.post<Map<String, dynamic>>(
      url: ApiEndpoints.showsAll,
      payload: show.toJson(),
    );

    return ShowModel.fromJson(response);
  }

  Future<ShowModel> editShow(ShowModel show) async {
    final response = await _client.put<Map<String, dynamic>>(
      url: ApiEndpoints.showsAll, // Assuming the URL is `/shows/id`
      payload: show.toJson(),
    );

    return ShowModel.fromJson(response);
  }

  Future<void> deleteShow(String showId) async {
    await _client.delete(
      url: ApiEndpoints.showsAll,
    );
  }
}
