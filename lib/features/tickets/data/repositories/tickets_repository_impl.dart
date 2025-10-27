// lib/features/tickets/data/repositories/tickets_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/errors/exceptions.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/tickets/data/datasources/tickets_remote_data_source.dart';
import 'package:ticketing/features/tickets/data/models/scan_response_model.dart';
import 'package:ticketing/features/tickets/domain/entities/ticket_entity.dart';
import 'package:ticketing/features/tickets/domain/repositories/tickets_repository.dart';

@LazySingleton(as: TicketsRepository)
class TicketsRepositoryImpl implements TicketsRepository {
  final TicketsRemoteDataSource _remoteDataSource;

  TicketsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, TicketEntity>> scanTicket(
      String qrCodeData, String stageId) async {
    try {
      final scanResponse =
          await _remoteDataSource.scanTicket(qrCodeData, stageId);
      final ticketEntity = _mapScanResponseToEntity(scanResponse, qrCodeData);
      return Right(ticketEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  TicketEntity _mapScanResponseToEntity(
      ScanResponseModel response, String qrCodeData) {
    return TicketEntity(
      id: response.ticket.id.toString(),
      eventId: response.show.id.toString(),
      eventName: response.show.name,
      ticketType: response.ticket.ticket_type.id.toString(),
      ticketTypeName: response.ticket.ticket_type.name,
      attendeeEmail: response.email,
      attendeeName:
          response.phone_number, // Using phone as name if name not available
      attendeePhone: response.phone_number,
      eventDate: response.show.date,
      status: _determineTicketStatus(response.ticket),
      qrCodeData: qrCodeData,
      isValid:
          response.payment_status == 'completed' && !response.ticket.closed,
      message: _getTicketMessage(response),
      checkedIn: response.checked_in,
      checkedInAt: null, // API doesn't provide this in sample
      price: response.ticket.price,
      seatName: response.ticket.seat?.name,
      seatRow: response.ticket.seat?.seat_row,
      paymentStatus: response.payment_status,
      paymentId: response.payment_id,
    );
  }

  String _determineTicketStatus(TicketDetailModel ticket) {
    if (ticket.closed) return 'closed';
    if (ticket.booked) return 'booked';
    if (ticket.reserved) return 'reserved';
    return 'available';
  }

  String? _getTicketMessage(ScanResponseModel response) {
    if (!response.checked_in) {
      return 'Ticket checked in successfully';
    }
    return 'Ticket was already checked in';
  }

  @override
  Future<Either<Failure, void>> validateTicket(
      String ticketId, String stageId) async {
    try {
      await _remoteDataSource.validateTicket(ticketId, stageId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TicketEntity>>> getScannedTickets(
      String stageId) async {
    try {
      final ticketModels = await _remoteDataSource.getScannedTickets(stageId);
      // Fix null safety issue
      final tickets = ticketModels.map((model) => model.toEntity()).toList();
      return Right(tickets);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TicketEntity>> getTicketById(String ticketId) async {
    try {
      final ticketModel = await _remoteDataSource.getTicketById(ticketId);
      return Right(ticketModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> reserveTicket(String ticketId) async {
    try {
      await _remoteDataSource.reserveTicket(ticketId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
