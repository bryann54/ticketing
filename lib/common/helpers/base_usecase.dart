// base_usecase.dart
import 'package:ticketing/core/errors/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  // Return non-nullable Type
  Future<Either<Failure, Type>> call(Params params);
}

// Pass this when the usecase expects no parameters
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}