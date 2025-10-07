// lib/features/tickets/presentation/bloc/tickets_event.dart

import 'package:equatable/equatable.dart';

abstract class TicketsEvent extends Equatable {
  const TicketsEvent();

  @override
  List<Object> get props => [];
}

class ScanTicketEvent extends TicketsEvent {
  final String qrCodeData;
  final String showId;

  const ScanTicketEvent(this.qrCodeData, this.showId);

  @override
  List<Object> get props => [qrCodeData, showId];
}

class ValidateTicketEvent extends TicketsEvent {
  final String ticketId;

  const ValidateTicketEvent(this.ticketId);

  @override
  List<Object> get props => [ticketId];
}

class LoadScannedTicketsEvent extends TicketsEvent {
  const LoadScannedTicketsEvent();
}

class ToggleScannerEvent extends TicketsEvent {
  final bool showScanner;

  const ToggleScannerEvent(this.showScanner);

  @override
  List<Object> get props => [showScanner];
}

class ResetTicketStateEvent extends TicketsEvent {
  const ResetTicketStateEvent();
}
