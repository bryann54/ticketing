import 'package:ticketing/common/helpers/base_usecase.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/account/data/datasources/account_local_datasource.dart';
import 'package:ticketing/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AccountRepository)
class AccountRepositoryImpl implements AccountRepository {
  final AccountLocalDatasource _localDataSource;

  AccountRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, NoParams>> changeLanguage(String languageCode) async {
    await _localDataSource.changeLanguage(languageCode);
    return Right(NoParams());
  }
}
