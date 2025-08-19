// lib/features/home/presentation/bloc/home_bloc.dart

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/features/home/presentation/bloc/home_event.dart';
import 'package:ticketing/features/home/presentation/bloc/home_state.dart';
import 'package:ticketing/features/shows/data/models/get_shows_query_model.dart';
import 'package:ticketing/features/shows/domain/repositories/shows_repository.dart';
import 'package:ticketing/features/venues/domain/repositories/venues_repository.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ShowsRepository _showsRepository;
  final VenuesRepository _venuesRepository;

  HomeBloc(this._showsRepository, this._venuesRepository)
      : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<CreateShow>(_onCreateShow);
    on<EditShow>(_onEditShow);
    on<DeleteShow>(_onDeleteShow);
  }

  Future<void> _onLoadHomeData(
      LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final showsResult = await _showsRepository.getShows(GetShowsQueryModel());
    final venuesResult = await _venuesRepository.getVenues();

    showsResult.fold(
      (failure) => emit(HomeError(failure: failure)),
      (shows) {
        venuesResult.fold(
          (failure) => emit(HomeError(failure: failure)),
          (venues) => emit(HomeLoaded(shows: shows, venues: venues)),
        );
      },
    );
  }

  Future<void> _onCreateShow(CreateShow event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final result = await _showsRepository.createShow(event.newShow);
    result.fold(
      (failure) => emit(HomeError(failure: failure)),
      (newShow) {
        add(const LoadHomeData()); // Reload data after successful creation
      },
    );
  }

  Future<void> _onEditShow(EditShow event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final result = await _showsRepository.editShow(event.updatedShow);
    result.fold(
      (failure) => emit(HomeError(failure: failure)),
      (updatedShow) {
        add(const LoadHomeData()); // Reload data after successful edit
      },
    );
  }

  Future<void> _onDeleteShow(DeleteShow event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final result = await _showsRepository.deleteShow(event.showId.toString());
    result.fold(
      (failure) => emit(HomeError(failure: failure)),
      (_) {
        add(const LoadHomeData()); // Reload data after successful delete
      },
    );
  }
}
