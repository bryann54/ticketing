// lib/features/auth/data/repositories/merchant_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/errors/exceptions.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/auth/data/datasources/merchant_remote_datasource.dart';
import 'package:ticketing/features/auth/data/models/merchant_model.dart';
import 'package:ticketing/features/auth/domain/repositories/merchant_repository.dart';

@LazySingleton(as: MerchantRepository)
class MerchantRepositoryImpl implements MerchantRepository {
  final MerchantRemoteDatasource _remoteDatasource;

  MerchantRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, MerchantModel>> createMerchant({
    required String businessName,
    required String businessEmail,
    required String businessTelephone,
  }) async {
    try {
      final merchant = await _remoteDatasource.createMerchant(
        businessName: businessName,
        businessEmail: businessEmail,
        businessTelephone: businessTelephone,
      );
      return Right(merchant);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
