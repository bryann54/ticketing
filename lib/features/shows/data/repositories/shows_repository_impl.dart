// lib/features/shows/data/repositories/shows_repository_impl.dart

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

    return switch (result) {
      client_provider.Success<List<ShowModel>>(:final data) => Right(data),
      client_provider.Failure<List<ShowModel>>(:final error) =>
        Left(ServerFailure(badResponse: error)),
    };
  }

  @override
  Future<Either<Failure, ShowModel>> createShow(ShowModel show) async {
    final result = await _remoteDatasource.createShow(show);

    return switch (result) {
      client_provider.Success<ShowModel>(:final data) => Right(data),
      client_provider.Failure<ShowModel>(:final error) =>
        Left(ServerFailure(badResponse: error)),
    };
  }

  @override
  Future<Either<Failure, ShowModel>> editShow(ShowModel show) async {
    final result = await _remoteDatasource.editShow(show);

    return switch (result) {
      client_provider.Success<ShowModel>(:final data) => Right(data),
      client_provider.Failure<ShowModel>(:final error) =>
        Left(ServerFailure(badResponse: error)),
    };
  }

  @override
  Future<Either<Failure, void>> deleteShow(String showId) async {
    final result = await _remoteDatasource.deleteShow(showId);

    return switch (result) {
      client_provider.Success<void>() => const Right(null),
      client_provider.Failure<void>(:final error) =>
        Left(ServerFailure(badResponse: error)),
    };
  }
}
