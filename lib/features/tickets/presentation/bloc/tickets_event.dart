// lib/features/tickets/presentation/bloc/tickets_event.dart

import 'package:equatable/equatable.dart';

abstract class TicketsEvent extends Equatable {
  const TicketsEvent();

  @override
  List<Object> get props => [];
}

class ScanTicketEvent extends TicketsEvent {
  final String qrCodeData;
  final String stageId; 

  const ScanTicketEvent(this.qrCodeData, this.stageId);

  @override
  List<Object> get props => [qrCodeData, stageId];
}

class ValidateTicketEvent extends TicketsEvent {
  final String ticketId;
  final String stageId;

  const ValidateTicketEvent(this.ticketId, this.stageId);

  @override
  List<Object> get props => [ticketId, stageId];
}

class LoadScannedTicketsEvent extends TicketsEvent {
  final String stageId;

  const LoadScannedTicketsEvent(this.stageId);

  @override
  List<Object> get props => [stageId];
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
class ReserveTicketEvent extends TicketsEvent {
  final String ticketId;

  const ReserveTicketEvent(this.ticketId);

  @override
  List<Object> get props => [ticketId];
}
