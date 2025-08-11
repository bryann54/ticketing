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
      // Specify the expected list type
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

    // Should not be reached, but good practice to handle all cases
    return Failure(ServerError());
  }
}
