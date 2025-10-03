// lib/features/merchant/domain/usecases/get_merchant_details_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/merchant/data/models/merchant_model.dart';
import 'package:ticketing/features/merchant/domain/repositories/merchant_repository.dart';

@injectable
class GetMerchantDetailsUseCase {
  final MerchantRepository repository;

  GetMerchantDetailsUseCase(this.repository);

  Future<Either<Failure, MerchantModel>> call() async {
    return await repository.getMerchantDetails();
  }
}
