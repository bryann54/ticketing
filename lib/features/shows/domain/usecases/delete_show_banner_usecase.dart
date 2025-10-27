// lib/features/shows/domain/usecases/delete_show_banner_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/common/helpers/base_usecase.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/core/storage/firebase_storage_service.dart';

@lazySingleton
class DeleteShowBannerUsecase implements UseCase<void, String> {
  final FirebaseStorageService _storageService;

  DeleteShowBannerUsecase(this._storageService);

  @override
  Future<Either<Failure, void>> call(String imageUrl) async {
    try {
      await _storageService.deleteShowBanner(imageUrl);
      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(message: 'Failed to delete banner: $e'));
    }
  }
}
