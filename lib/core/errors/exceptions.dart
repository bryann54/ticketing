class ServerException implements Exception {
  final String? message;
  final int? statusCode;

  ServerException({this.message, this.statusCode});
}

class CacheException implements Exception {}

class DatabaseException implements Exception {}

class ClientException implements Exception {
  final String message;
  ClientException({required this.message});
}
