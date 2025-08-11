import 'package:ticketing/common/helpers/base_usecase.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/venues/data/datasources/venues_remote_datasource.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart'; // Import VenueModel
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
    final result = await _remoteDatasource.getVenues();

    if (result is apiClient.Success) {
      return Right(NoParams() as List<VenueModel>);
    } else if (result is apiClient.Failure) {
      return Left(ServerFailure());
    }

    return Left(GeneralFailure(error: 'An unknown error occurred.'));
  }
}