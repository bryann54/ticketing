import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/shows/data/models/get_shows_query_model.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:dartz/dartz.dart';

abstract class ShowsRepository {
  Future<Either<Failure, List<ShowModel>>> getShows(GetShowsQueryModel query);
}
