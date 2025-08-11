import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart'; // Import VenueModel
import 'package:dartz/dartz.dart';

abstract class VenuesRepository {
  Future<Either<Failure, List<VenueModel>>> getVenues();
}
