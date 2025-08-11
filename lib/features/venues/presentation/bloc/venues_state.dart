import 'package:equatable/equatable.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart'; // Import VenueModel

sealed class VenuesState extends Equatable {
  const VenuesState();

  @override
  List<Object> get props => [];
}

final class VenuesInitial extends VenuesState {}

final class VenuesLoading extends VenuesState {}

final class VenuesLoaded extends VenuesState {
  final List<VenueModel> venues;
  const VenuesLoaded({required this.venues});
  @override
  List<Object> get props => [venues];
}

final class VenuesError extends VenuesState {
  final Failure failure;
  const VenuesError({required this.failure});
  @override
  List<Object> get props => [failure];
}
