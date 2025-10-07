// lib/features/merchant/data/repositories/merchant_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/errors/exceptions.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/merchant/data/datasources/merchant_remote_datasource.dart';
import 'package:ticketing/features/merchant/data/models/merchant_model.dart';
import 'package:ticketing/features/merchant/domain/repositories/merchant_repository.dart';

@LazySingleton(as: MerchantRepository)
class MerchantRepositoryImpl implements MerchantRepository {
  final MerchantRemoteDatasource _remoteDatasource;

  MerchantRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, MerchantModel>> createMerchant({
    required String name,
    required String businessEmail,
    required String businessTelephone,
  }) async {
    try {
      final merchant = await _remoteDatasource.createMerchant(
        name: name,
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

  @override
  Future<Either<Failure, MerchantModel>> getMerchantDetails() async {
    try {
      final merchant = await _remoteDatasource.getMerchantDetails();
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
