import 'package:equatable/equatable.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ShowModel> shows;
  final List<VenueModel> venues;

  const HomeLoaded({
    required this.shows,
    required this.venues,
  });

  @override
  List<Object> get props => [shows, venues];
}

final class HomeError extends HomeState {
  final Failure failure;
  const HomeError({required this.failure});

  @override
  List<Object> get props => [failure];
}
