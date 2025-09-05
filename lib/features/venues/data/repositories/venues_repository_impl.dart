// lib/features/venues/data/repositories/venues_repository_impl.dart

import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/core/errors/exceptions.dart';
import 'package:ticketing/features/venues/data/datasources/venues_remote_datasource.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart';
import 'package:ticketing/features/venues/domain/repositories/venues_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: VenuesRepository)
class VenuesRepositoryImpl implements VenuesRepository {
  final VenuesRemoteDatasource _remoteDatasource;

  VenuesRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, List<VenueModel>>> getVenues() async {
    try {
      // Call the remote datasource. This can throw a ServerException.
      final venues = await _remoteDatasource.getVenues();
      // If the call is successful, return the data wrapped in a Right.
      return Right(venues);
    } on ServerException catch (e) {
      // Catch the specific exception from the datasource and map it to a domain failure.
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on ConnectionFailure catch (e) {
      // This catch block handles network connectivity issues.
      return Left(ConnectionFailure(message: e.message));
    } catch (e) {
      // Catch any other unexpected errors and return a general failure.
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
