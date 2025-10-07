// lib/features/tickets/presentation/bloc/tickets_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/features/tickets/domain/usecases/tickets_usecases.dart';
import 'tickets_event.dart';
import 'tickets_state.dart';

@injectable
class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  final ScanTicketUseCase _scanTicketUseCase;
  final ValidateTicketUseCase _validateTicketUseCase;
  final GetScannedTicketsUseCase _getScannedTicketsUseCase;

  TicketsBloc({
    required ScanTicketUseCase scanTicketUseCase,
    required ValidateTicketUseCase validateTicketUseCase,
    required GetScannedTicketsUseCase getScannedTicketsUseCase,
  })  : _scanTicketUseCase = scanTicketUseCase,
        _validateTicketUseCase = validateTicketUseCase,
        _getScannedTicketsUseCase = getScannedTicketsUseCase,
        super(const TicketsState()) {
    on<ScanTicketEvent>(_onScanTicket);
    on<ValidateTicketEvent>(_onValidateTicket);
    on<LoadScannedTicketsEvent>(_onLoadScannedTickets);
    on<ResetTicketStateEvent>(_onResetTicketState);
  }

  Future<void> _onScanTicket(
    ScanTicketEvent event,
    Emitter<TicketsState> emit,
  ) async {
    emit(state.copyWith(
      status: TicketsStatus.loading,
      isScanning: true,
      errorMessage: null,
    ));

    final result = await _scanTicketUseCase(event.qrCodeData);

    result.fold(
      (failure) => emit(state.copyWith(
        status: TicketsStatus.scanError,
        errorMessage: failure.message,
        isScanning: false,
      )),
      (ticket) => emit(state.copyWith(
        status: TicketsStatus.scanSuccess,
        currentTicket: ticket,
        isScanning: false,
      )),
    );
  }

  Future<void> _onValidateTicket(
    ValidateTicketEvent event,
    Emitter<TicketsState> emit,
  ) async {
    emit(state.copyWith(
      status: TicketsStatus.loading,
      errorMessage: null,
    ));

    final result = await _validateTicketUseCase(event.ticketId);

    result.fold(
      (failure) => emit(state.copyWith(
        status: TicketsStatus.validateError,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        status: TicketsStatus.validateSuccess,
      )),
    );
  }

  Future<void> _onLoadScannedTickets(
    LoadScannedTicketsEvent event,
    Emitter<TicketsState> emit,
  ) async {
    emit(state.copyWith(
      status: TicketsStatus.loading,
      errorMessage: null,
    ));

    final result = await _getScannedTicketsUseCase();

    result.fold(
      (failure) => emit(state.copyWith(
        status: TicketsStatus.loadScannedError,
        errorMessage: failure.message,
      )),
      (tickets) => emit(state.copyWith(
        status: TicketsStatus.loadScannedSuccess,
        scannedTickets: tickets,
      )),
    );
  }

  Future<void> _onResetTicketState(
    ResetTicketStateEvent event,
    Emitter<TicketsState> emit,
  ) async {
    emit(const TicketsState());
  }
}
