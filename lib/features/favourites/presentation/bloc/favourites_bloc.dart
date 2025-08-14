import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/features/favourites/data/services/favourites_service.dart';
import 'package:ticketing/features/favourites/presentation/bloc/favourites_event.dart';
import 'package:ticketing/features/favourites/presentation/bloc/favourites_state.dart';

@injectable
class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final FavouritesService _favouritesService;
  List<int> _favouriteShowIds = [];
  List<int> _favouriteVenueIds = [];

  FavouritesBloc(this._favouritesService) : super(FavouritesInitial()) {
    on<LoadFavourites>(_onLoadFavourites);
    on<ToggleFavouriteShow>(_onToggleFavouriteShow);
    on<ToggleFavouriteVenue>(_onToggleFavouriteVenue);
  }

  Future<void> _onLoadFavourites(
      LoadFavourites event, Emitter<FavouritesState> emit) async {
    emit(FavouritesLoading());
    final showResult = await _favouritesService.getFavouriteShowIds();
    final venueResult = await _favouritesService.getFavouriteVenueIds();

    showResult.fold(
      (failure) => emit(FavouritesError(failure: failure)),
      (showIds) {
        venueResult.fold(
          (failure) => emit(FavouritesError(failure: failure)),
          (venueIds) {
            _favouriteShowIds = showIds;
            _favouriteVenueIds = venueIds;
            emit(FavouritesLoaded(
                favouriteShowIds: _favouriteShowIds,
                favouriteVenueIds: _favouriteVenueIds));
          },
        );
      },
    );
  }

  Future<void> _onToggleFavouriteShow(
      ToggleFavouriteShow event, Emitter<FavouritesState> emit) async {
    if (_favouriteShowIds.contains(event.showId)) {
      _favouriteShowIds.remove(event.showId);
    } else {
      _favouriteShowIds.add(event.showId);
    }
    await _favouritesService.saveFavouriteShowIds(_favouriteShowIds);
    emit(FavouritesLoaded(
        favouriteShowIds: _favouriteShowIds,
        favouriteVenueIds: _favouriteVenueIds));
  }

  Future<void> _onToggleFavouriteVenue(
      ToggleFavouriteVenue event, Emitter<FavouritesState> emit) async {
    if (_favouriteVenueIds.contains(event.venueId)) {
      _favouriteVenueIds.remove(event.venueId);
    } else {
      _favouriteVenueIds.add(event.venueId);
    }
    await _favouritesService.saveFavouriteVenueIds(_favouriteVenueIds);
    emit(FavouritesLoaded(
        favouriteShowIds: _favouriteShowIds,
        favouriteVenueIds: _favouriteVenueIds));
  }
}
