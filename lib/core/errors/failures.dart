import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message; // Made nullable for flexibility

  const Failure({this.message});

  @override
  List<Object?> get props => [message]; // Include message in props

  // Add a default toString for easier debugging
  @override
  String toString() => 'Failure: ${message ?? 'An unexpected error occurred.'}';
}

// General failures
class ServerFailure extends Failure {
  final String? message; // Change to nullable
  final int? statusCode;

  const ServerFailure({this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];

  @override
  String toString() {
    return 'ServerFailure: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
  }
}

class CacheFailure extends Failure {
  final String message;

  const CacheFailure({this.message = 'Failed to retrieve data from cache.'});

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'CacheFailure: $message';
}

class ConnectionFailure extends Failure {
  final String message;

  const ConnectionFailure(
      {this.message =
          'Failed to connect to the internet. Please check your connection.'});

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'ConnectionFailure: $message';
}

class ClientFailure extends Failure {
  final String message;

  const ClientFailure({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'ClientFailure: $message';
}

class GeneralFailure extends Failure {
  final String message;

  const GeneralFailure({this.message = 'An unexpected error occurred.'});

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'GeneralFailure: $message';
}

class ValidationFailure extends Failure {
  final String message;

  const ValidationFailure(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'ValidationFailure: $message';
}

// Specific HTTP failures
class UnauthorizedFailure extends Failure {
  final String message;
  const UnauthorizedFailure(
      {this.message = 'Authentication failed. Please check your credentials.'});
  @override
  List<Object?> get props => [message];
  @override
  String toString() => 'UnauthorizedFailure: $message';
}

class ForbiddenFailure extends Failure {
  final String message;
  const ForbiddenFailure(
      {this.message = 'You do not have permission to access this resource.'});
  @override
  List<Object?> get props => [message];
  @override
  String toString() => 'ForbiddenFailure: $message';
}
