import 'package:equatable/equatable.dart';

sealed class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

final class LoadFavourites extends FavouritesEvent {}

final class ToggleFavouriteShow extends FavouritesEvent {
  final int showId;
  const ToggleFavouriteShow(this.showId);

  @override
  List<Object> get props => [showId];
}

final class ToggleFavouriteVenue extends FavouritesEvent {
  final int venueId;
  const ToggleFavouriteVenue(this.venueId);

  @override
  List<Object> get props => [venueId];
}
