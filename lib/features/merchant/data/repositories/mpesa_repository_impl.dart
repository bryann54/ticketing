// lib/features/merchant/data/repositories/mpesa_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/errors/exceptions.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/merchant/data/datasources/mpesa_remote_datasource.dart';
import 'package:ticketing/features/merchant/domain/repositories/mpesa_repository.dart';

@LazySingleton(as: MpesaRepository)
class MpesaRepositoryImpl implements MpesaRepository {
  final MpesaRemoteDatasource _remoteDatasource;

  MpesaRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, void>> addMpesaDetails({
    required String consumerKey,
    required String consumerSecret,
    required String shortCode,
    required String passKey,
    required String integrationType,
    required String partyB,
  }) async {
    try {
      await _remoteDatasource.addMpesaDetails(
        consumerKey: consumerKey,
        consumerSecret: consumerSecret,
        shortCode: shortCode,
        passKey: passKey,
        integrationType: integrationType,
        partyB: partyB,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
