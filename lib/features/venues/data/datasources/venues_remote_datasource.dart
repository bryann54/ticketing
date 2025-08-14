import 'package:ticketing/core/api_client/client_provider.dart' as apiClient;
import 'package:ticketing/core/api_client/endpoints/api_endpoints.dart';
import 'package:ticketing/core/api_client/models/server_error.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart'; // Import VenueModel
import 'package:injectable/injectable.dart';

@lazySingleton
class VenuesRemoteDatasource {
  final apiClient.ApiClient _client;

  VenuesRemoteDatasource(this._client);

  Future<apiClient.ApiResponse<List<VenueModel>>> getVenues() async {
    // Assuming the API endpoint to get all venues is /venues/all/
    final response = await _client.get<List<dynamic>>(
      url: ApiEndpoints
          .venuesAll, // Ensure this endpoint is correct in ApiEndpoints
    );

    if (response is apiClient.Success<List<dynamic>>) {
      final List<VenueModel> venues = response.data
          .map((item) => VenueModel.fromJson(item as Map<String, dynamic>))
          .toList();
      return apiClient.Success(venues);
    } else if (response is apiClient.Failure) {
      return apiClient.Failure(ServerError());
    }

    return apiClient.Failure(ServerError());
  }
}
