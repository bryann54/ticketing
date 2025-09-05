// lib/features/shows/data/repositories/shows_repository_impl.dart

import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/core/errors/exceptions.dart';
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
    try {
      final shows = await _remoteDatasource.getShows(query);
      return Right(shows);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ShowModel>> createShow(ShowModel show) async {
    try {
      final createdShow = await _remoteDatasource.createShow(show);
      return Right(createdShow);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ShowModel>> editShow(ShowModel show) async {
    try {
      final editedShow = await _remoteDatasource.editShow(show);
      return Right(editedShow);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteShow(String showId) async {
    try {
      await _remoteDatasource.deleteShow(showId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
