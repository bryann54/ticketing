// lib/features/tickets/presentation/bloc/tickets_state.dart

import 'package:equatable/equatable.dart';
import 'package:ticketing/features/tickets/domain/entities/ticket_entity.dart';

enum TicketsStatus {
  initial,
  loading,
  scanSuccess,
  scanError,
  validateSuccess,
  validateError,
  loadScannedSuccess,
  loadScannedError,
}

class TicketsState extends Equatable {
  final TicketsStatus status;
  final List<TicketEntity> scannedTickets;
  final TicketEntity? currentTicket;
  final String? errorMessage;
  final bool isScanning;

  const TicketsState({
    this.status = TicketsStatus.initial,
    this.scannedTickets = const [],
    this.currentTicket,
    this.errorMessage,
    this.isScanning = false,
  });

  @override
  List<Object?> get props => [
        status,
        scannedTickets,
        currentTicket,
        errorMessage,
        isScanning,
      ];

  TicketsState copyWith({
    TicketsStatus? status,
    List<TicketEntity>? scannedTickets,
    TicketEntity? currentTicket,
    String? errorMessage,
    bool? isScanning,
  }) {
    return TicketsState(
      status: status ?? this.status,
      scannedTickets: scannedTickets ?? this.scannedTickets,
      currentTicket: currentTicket ?? this.currentTicket,
      errorMessage: errorMessage ?? this.errorMessage,
      isScanning: isScanning ?? this.isScanning,
    );
  }
}
