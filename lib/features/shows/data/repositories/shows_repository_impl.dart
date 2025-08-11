import 'package:ticketing/core/api_client/client_provider.dart'
    as client_provider;
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/shows/data/datasources/shows_remote_datasource.dart';
import 'package:ticketing/features/shows/data/models/get_shows_query_model.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:ticketing/features/shows/domain/repositories/shows_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ShowsRepository)
class ShowsRepositoryImpl implements ShowsRepository {
  final ShowsRemoteDatasource _remoteDatasource;

  ShowsRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, List<ShowModel>>> getShows(
      GetShowsQueryModel query) async {
    final result = await _remoteDatasource.getShows(query);

    // Use pattern matching instead of fold
    return switch (result) {
      client_provider.Success<List<ShowModel>>(:final data) => Right(data),
      client_provider.Failure<List<ShowModel>>(:final error) =>
        Left(ServerFailure(badResponse: error)),
    };
  }
}
