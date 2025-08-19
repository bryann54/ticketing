// lib/features/shows/domain/repositories/shows_repository.dart

import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/shows/data/models/get_shows_query_model.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:dartz/dartz.dart';

abstract class ShowsRepository {
  Future<Either<Failure, List<ShowModel>>> getShows(GetShowsQueryModel query);

  Future<Either<Failure, ShowModel>> createShow(ShowModel show);
  Future<Either<Failure, ShowModel>> editShow(ShowModel show);
  Future<Either<Failure, void>> deleteShow(String showId);
}
