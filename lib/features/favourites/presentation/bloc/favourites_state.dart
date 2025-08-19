import 'package:equatable/equatable.dart';
import 'package:ticketing/core/errors/failures.dart';

sealed class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object> get props => [];
}

final class FavouritesInitial extends FavouritesState {}

final class FavouritesLoading extends FavouritesState {}

final class FavouritesLoaded extends FavouritesState {
  final List<int> favouriteShowIds;
  final List<int> favouriteVenueIds;
  const FavouritesLoaded({
    required this.favouriteShowIds,
    required this.favouriteVenueIds,
  });

  @override
  List<Object> get props => [favouriteShowIds, favouriteVenueIds];
}

final class FavouritesError extends FavouritesState {
  final Failure failure;
  const FavouritesError({required this.failure});
  @override
  List<Object> get props => [failure];
}
