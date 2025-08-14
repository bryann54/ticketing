import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/common/helpers/base_usecase.dart'; // For NoParams
import 'package:ticketing/features/home/presentation/bloc/home_event.dart';
import 'package:ticketing/features/home/presentation/bloc/home_state.dart';
import 'package:ticketing/features/shows/domain/usecases/get_shows_usecase.dart';
import 'package:ticketing/features/venues/domain/usecases/get_venues_usecase.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetShowsUsecase _getShowsUsecase;
  final GetVenuesUsecase _getVenuesUsecase;

  HomeBloc(this._getShowsUsecase, this._getVenuesUsecase)
      : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  FutureOr<void> _onLoadHomeData(
      LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    // Fetch shows and venues concurrently
    final showsResult = await _getShowsUsecase.call(GetShowsParams());
    final venuesResult = await _getVenuesUsecase.call(NoParams());

    showsResult.fold(
      (showsFailure) {
        emit(HomeError(failure: showsFailure));
      },
      (shows) {
        venuesResult.fold(
          (venuesFailure) {
            emit(HomeError(failure: venuesFailure));
          },
          (venues) {
            emit(HomeLoaded(shows: shows, venues: venues));
          },
        );
      },
    );
  }
}
