// lib/features/venues/data/datasources/venues_remote_datasource.dart

import 'package:ticketing/core/api_client/client/client/api_client.dart';
import 'package:ticketing/core/api_client/endpoints/api_endpoints.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VenuesRemoteDatasource {
  final ApiClient _client;

  VenuesRemoteDatasource(this._client);

  Future<List<VenueModel>> getVenues() async {
    // Make the API call directly. The ApiClient will throw an exception on error.
    final response = await _client.get<List<dynamic>>(
      url: ApiEndpoints.venuesAll,
    );

    // If the call succeeds, parse the raw JSON data into a list of VenueModels.
    final List<VenueModel> venues = response
        .map((item) => VenueModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return venues;
  }
}
