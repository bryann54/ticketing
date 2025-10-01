// lib/features/auth/domain/usecases/create_merchant_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/auth/data/models/merchant_model.dart';
import 'package:ticketing/features/auth/domain/repositories/merchant_repository.dart';

@lazySingleton
class CreateMerchantUseCase {
  final MerchantRepository _repository;

  CreateMerchantUseCase(this._repository);

  Future<Either<Failure, MerchantModel>> call({
    required String businessName,
    required String businessEmail,
    required String businessTelephone,
  }) async {
    return await _repository.createMerchant(
      businessName: businessName,
      businessEmail: businessEmail,
      businessTelephone: businessTelephone,
    );
  }
}
