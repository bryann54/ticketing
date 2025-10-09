

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/merchant/data/models/merchant_model.dart';
import 'package:ticketing/features/merchant/domain/repositories/merchant_repository.dart';

@injectable
class UpdateMerchantUseCase {
  final MerchantRepository _repository; 
  UpdateMerchantUseCase(this._repository);
  Future<Either<Failure, MerchantModel>> call({
    required String name,
    required String businessEmail,
    required String businessTelephone,
  }) async {
    return await _repository.updateMerchant(
      name: name,
      businessEmail: businessEmail,
      businessTelephone: businessTelephone,
    );
  }
}