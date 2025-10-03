// lib/features/auth/domain/repositories/merchant_repository.dart

import 'package:dartz/dartz.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/merchant/data/models/merchant_model.dart';

abstract class MerchantRepository {
  Future<Either<Failure, MerchantModel>> createMerchant({
    required String name,
    required String businessEmail,
    required String businessTelephone,
  });
  Future<Either<Failure, MerchantModel>> getMerchantDetails();
}
