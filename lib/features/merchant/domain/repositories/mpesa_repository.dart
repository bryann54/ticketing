// lib/features/merchant/domain/repositories/mpesa_repository.dart

import 'package:dartz/dartz.dart';
import 'package:ticketing/core/errors/failures.dart';

abstract class MpesaRepository {
  Future<Either<Failure, void>> addMpesaDetails({
    required String consumerKey,
    required String consumerSecret,
    required String shortCode,
    required String passKey,
    required String integrationType,
    required String partyB,
  });
}
