import 'package:ticketing/common/helpers/base_usecase.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart'; // Import VenueModel
import 'package:ticketing/features/venues/domain/repositories/venues_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetVenuesUsecase implements UseCase<List<VenueModel>, NoParams> {
  final VenuesRepository _repo;

  GetVenuesUsecase(this._repo);

  @override
  Future<Either<Failure, List<VenueModel>>> call(NoParams params) async {
    return await _repo.getVenues();
  }
}
