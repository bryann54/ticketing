// lib/features/tickets/data/datasources/tickets_remote_data_source.dart

import 'package:injectable/injectable.dart';
import 'package:ticketing/core/api_client/client/api_client.dart';
import 'package:ticketing/core/errors/exceptions.dart';
import 'package:ticketing/features/tickets/data/models/ticket_model.dart';
import 'package:ticketing/core/api_client/endpoints/api_endpoints.dart';

abstract class TicketsRemoteDataSource {
  Future<TicketModel> scanTicket(String qrCodeData);
  Future<void> validateTicket(String ticketId);
  Future<List<TicketModel>> getScannedTickets();
  Future<TicketModel> getTicketById(String ticketId);
}

@LazySingleton(as: TicketsRemoteDataSource)
class TicketsRemoteDataSourceImpl implements TicketsRemoteDataSource {
  final ApiClient _apiClient;

  TicketsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<TicketModel> scanTicket(String qrCodeData) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        url: ApiEndpoints.showsTicketTypesCreate,
        payload: {
          'qr_code_data': qrCodeData,
        },
      );
      return TicketModel.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }

  @override
  Future<void> validateTicket(String ticketId) async {
    try {
      await _apiClient.post<void>(
        url: ApiEndpoints.showsTicketTypesCreate,
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
  Future<List<TicketModel>> getScannedTickets() async {
    try {
      final response = await _apiClient.get<List<dynamic>>(
        url: ApiEndpoints.showsTicketTypesCreate,
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
        url: '${ApiEndpoints.showsTicketTypesCreate}/$ticketId',
      );
      return TicketModel.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ClientException catch (e) {
      throw ClientException(message: e.message);
    }
  }
}
