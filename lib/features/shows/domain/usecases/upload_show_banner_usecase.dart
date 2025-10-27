// lib/features/shows/domain/usecases/upload_show_banner_usecase.dart

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/common/helpers/base_usecase.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/core/storage/firebase_storage_service.dart';

class UploadShowBannerParams {
  final File imageFile;
  final String showName;

  UploadShowBannerParams({
    required this.imageFile,
    required this.showName,
  });
}

@lazySingleton
class UploadShowBannerUsecase
    implements UseCase<String, UploadShowBannerParams> {
  final FirebaseStorageService _storageService;

  UploadShowBannerUsecase(this._storageService);

  @override
  Future<Either<Failure, String>> call(UploadShowBannerParams params) async {
    try {
      final fileName = _storageService.generateFileName(
        params.imageFile,
        params.showName,
      );
      final downloadUrl = await _storageService.uploadShowBanner(
        params.imageFile,
        fileName,
      );
      return Right(downloadUrl);
    } catch (e) {
      return Left(GeneralFailure(message: 'Failed to upload banner: $e'));
    }
  }
}
