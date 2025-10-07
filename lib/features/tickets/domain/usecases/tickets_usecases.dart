// lib/features/tickets/domain/usecases/tickets_usecases.dart

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/tickets/domain/entities/ticket_entity.dart';
import 'package:ticketing/features/tickets/domain/repositories/tickets_repository.dart';

@lazySingleton
class ScanTicketUseCase {
  final TicketsRepository repository;
  ScanTicketUseCase(this.repository);

  Future<Either<Failure, TicketEntity>> call(String qrCodeData) async {
    return await repository.scanTicket(qrCodeData);
  }
}

@lazySingleton
class ValidateTicketUseCase {
  final TicketsRepository repository;
  ValidateTicketUseCase(this.repository);

  Future<Either<Failure, void>> call(String ticketId) async {
    return await repository.validateTicket(ticketId);
  }
}

@lazySingleton
class GetScannedTicketsUseCase {
  final TicketsRepository repository;
  GetScannedTicketsUseCase(this.repository);

  Future<Either<Failure, List<TicketEntity>>> call() async {
    return await repository.getScannedTickets();
  }
}

@lazySingleton
class GetTicketByIdUseCase {
  final TicketsRepository repository;
  GetTicketByIdUseCase(this.repository);

  Future<Either<Failure, TicketEntity>> call(String ticketId) async {
    return await repository.getTicketById(ticketId);
  }
}
