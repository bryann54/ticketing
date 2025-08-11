import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/common/helpers/base_usecase.dart';
import 'package:ticketing/features/venues/domain/usecases/get_venues_usecase.dart';
import 'package:ticketing/features/venues/presentation/bloc/venues_event.dart';
import 'package:ticketing/features/venues/presentation/bloc/venues_state.dart';

@injectable
class VenuesBloc extends Bloc<VenuesEvent, VenuesState> {
  final GetVenuesUsecase _getVenuesUsecase;

  VenuesBloc(this._getVenuesUsecase) : super(VenuesInitial()) {
    on<GetVenuesEvent>(_onGetVenuesEvent);
  }

  FutureOr<void> _onGetVenuesEvent(
      GetVenuesEvent event, Emitter<VenuesState> emit) async {
    emit(VenuesLoading());
    final result = await _getVenuesUsecase.call(NoParams());
    result.fold(
      (failure) => emit(VenuesError(failure: failure)),
      (venues) => emit(VenuesLoaded(venues: venues)),
    );
  }
}
