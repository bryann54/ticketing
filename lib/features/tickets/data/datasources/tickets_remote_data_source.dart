// lib/features/tickets/data/datasources/tickets_remote_data_source.dart
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/api_client/client/api_client.dart';
import 'package:ticketing/core/errors/exceptions.dart';
import 'package:ticketing/features/tickets/data/models/scan_response_model.dart';
import 'package:ticketing/core/api_client/endpoints/api_endpoints.dart';
import 'package:ticketing/features/tickets/data/models/ticket_model.dart';

abstract class TicketsRemoteDataSource {
  Future<ScanResponseModel> scanTicket(String qrCodeData, String stageId);
  Future<void> validateTicket(String ticketId, String stageId);
  Future<List<TicketModel>> getScannedTickets(String stageId);
  Future<TicketModel> getTicketById(String ticketId);
  Future<void> reserveTicket(String ticketId);
}

@LazySingleton(as: TicketsRemoteDataSource)
class TicketsRemoteDataSourceImpl implements TicketsRemoteDataSource {
  final ApiClient _apiClient;

  TicketsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ScanResponseModel> scanTicket(
      String qrCodeData, String stageId) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        url: ApiEndpoints.showsTicketsCustomersCheckin(stageId),
        payload: {
          'qr_code_data': qrCodeData,
        },
      );

      // Handle nested payload structure from API
      final payload = response['payload'] as Map<String, dynamic>? ?? response;
      return ScanResponseModel.fromJson(payload);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    } catch (e) {
      throw ServerException(message: 'Failed to scan ticket: $e');
    }
  }

  @override
  Future<void> validateTicket(String ticketId, String stageId) async {
    try {
      await _apiClient.post<void>(
        url: ApiEndpoints.showsTicketsCustomersCheckin(stageId),
        payload: {
          'ticket_id': ticketId,
        },
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }

  @override
  Future<List<TicketModel>> getScannedTickets(String stageId) async {
    try {
      final response = await _apiClient.get<List<dynamic>>(
        url: ApiEndpoints.showsTicketsSalesStatus(stageId),
      );
      return response
          .map((item) => TicketModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }

  @override
  Future<TicketModel> getTicketById(String ticketId) async {
    try {
      final response = await _apiClient.get<Map<String, dynamic>>(
        url: ApiEndpoints.showsTicketsDetails(ticketId),
      );
      return TicketModel.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }

  @override
  Future<void> reserveTicket(String ticketId) async {
    try {
      await _apiClient.post<void>(
        url: ApiEndpoints.showsTicketsReserve,
        payload: {
          'ticket_id': ticketId,
        },
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }
}
