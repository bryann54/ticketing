// lib/features/tickets/domain/repositories/tickets_repository.dart

import 'package:dartz/dartz.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/tickets/domain/entities/ticket_entity.dart';

abstract class TicketsRepository {
  Future<Either<Failure, TicketEntity>> scanTicket(String qrCodeData);
  Future<Either<Failure, void>> validateTicket(String ticketId);
  Future<Either<Failure, List<TicketEntity>>> getScannedTickets();
  Future<Either<Failure, TicketEntity>> getTicketById(String ticketId);
}
