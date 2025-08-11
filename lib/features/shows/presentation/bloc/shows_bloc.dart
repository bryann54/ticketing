import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/features/shows/domain/usecases/get_shows_usecase.dart';
import 'package:ticketing/features/shows/presentation/bloc/shows_event.dart';
import 'package:ticketing/features/shows/presentation/bloc/shows_state.dart';

@injectable
class ShowsBloc extends Bloc<ShowsEvent, ShowsState> {
  final GetShowsUsecase _getShowsUsecase;

  ShowsBloc(this._getShowsUsecase) : super(ShowsInitial()) {
    on<GetShowsEvent>(_onGetShowsEvent);
  }

  FutureOr<void> _onGetShowsEvent(
      GetShowsEvent event, Emitter<ShowsState> emit) async {
    emit(ShowsLoading());
    final result = await _getShowsUsecase.call(event.params);
    result.fold(
      (failure) => emit(ShowsError(failure: failure)),
      (shows) => emit(ShowsLoaded(shows: shows)),
    );
  }
}
