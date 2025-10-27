// lib/features/shows/domain/usecases/delete_show_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/common/helpers/base_usecase.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/shows/domain/repositories/shows_repository.dart';

@lazySingleton
class DeleteShowUsecase implements UseCase<void, String> {
  final ShowsRepository _repo;

  DeleteShowUsecase(this._repo);

  @override
  Future<Either<Failure, void>> call(String showId) async {
    return await _repo.deleteShow(showId);
  }
}
