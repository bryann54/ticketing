// lib/features/venues/data/repositories/venues_repository_impl.dart

import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/venues/data/datasources/venues_remote_datasource.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart';
import 'package:ticketing/features/venues/domain/repositories/venues_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/api_client/client_provider.dart' as apiClient;

@LazySingleton(as: VenuesRepository)
class VenuesRepositoryImpl implements VenuesRepository {
  final VenuesRemoteDatasource _remoteDatasource;

  VenuesRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, List<VenueModel>>> getVenues() async {
    // Explicitly type the result from the remote datasource
    final result = await _remoteDatasource.getVenues();

    if (result is apiClient.Success<List<VenueModel>>) {
      // Now 'result' is correctly typed, and we can access 'data'
      return Right(result.data);
    } else if (result is apiClient.Failure) {
      // 'result' is correctly typed as a Failure, and we can access 'error'
      return Left(ServerFailure());
    }

    return Left(GeneralFailure(error: 'An unknown error occurred.'));
  }
}
