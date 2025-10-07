// lib/features/merchant/domain/usecases/add_mpesa_details.dart

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/merchant/domain/repositories/mpesa_repository.dart';

@lazySingleton
class AddMpesaDetails {
  final MpesaRepository repository;

  AddMpesaDetails(this.repository);

  Future<Either<Failure, void>> call(AddMpesaDetailsParams params) async {
    return await repository.addMpesaDetails(
      consumerKey: params.consumerKey,
      consumerSecret: params.consumerSecret,
      shortCode: params.shortCode,
      passKey: params.passKey,
      integrationType: params.integrationType,
      partyB: params.partyB,
    );
  }
}

class AddMpesaDetailsParams {
  final String consumerKey;
  final String consumerSecret;
  final String shortCode;
  final String passKey;
  final String integrationType;
  final String partyB;

  AddMpesaDetailsParams({
    required this.consumerKey,
    required this.consumerSecret,
    required this.shortCode,
    required this.passKey,
    required this.integrationType,
    required this.partyB,
  });
}
