import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/common/helpers/base_usecase.dart'; // Assuming you have this
import 'package:ticketing/features/shows/data/models/get_shows_query_model.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:ticketing/features/shows/domain/repositories/shows_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Parameters for the use case
class GetShowsParams {
  final int? venueId;
  final String? date;
  final String? showType;

  GetShowsParams({
    this.venueId,
    this.date,
    this.showType,
  });
}

@lazySingleton
class GetShowsUsecase implements UseCase<List<ShowModel>, GetShowsParams> {
  final ShowsRepository _repo;

  GetShowsUsecase(this._repo);

  @override
  Future<Either<Failure, List<ShowModel>>> call(GetShowsParams params) async {
    // Map the use case parameters to the data layer's query model
    final queryModel = GetShowsQueryModel(
      venue: params.venueId,
      date: params.date,
      showType: params.showType,
    );
    return await _repo.getShows(queryModel);
  }
}
