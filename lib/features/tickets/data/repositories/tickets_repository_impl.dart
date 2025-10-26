// lib/features/tickets/data/repositories/tickets_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/errors/exceptions.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/tickets/data/datasources/tickets_remote_data_source.dart';
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
      final ticketModel =
          await _remoteDataSource.scanTicket(qrCodeData, stageId);
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
}
