// lib/features/shows/domain/usecases/edit_show_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/common/helpers/base_usecase.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:ticketing/features/shows/domain/repositories/shows_repository.dart';

@lazySingleton
class EditShowUsecase implements UseCase<ShowModel, ShowModel> {
  final ShowsRepository _repo;

  EditShowUsecase(this._repo);

  @override
  Future<Either<Failure, ShowModel>> call(ShowModel show) async {
    return await _repo.editShow(show);
  }
}
