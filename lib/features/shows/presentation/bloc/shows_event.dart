import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:ticketing/features/shows/domain/usecases/get_shows_usecase.dart';

sealed class ShowsEvent extends Equatable {
  const ShowsEvent();
}

final class GetShowsEvent extends ShowsEvent {
  final GetShowsParams params;

  const GetShowsEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

final class UploadShowBannerEvent extends ShowsEvent {
  final File imageFile;
  final String showName;

  const UploadShowBannerEvent({
    required this.imageFile,
    required this.showName,
  });

  @override
  List<Object?> get props => [imageFile, showName];
}

final class CreateShowEvent extends ShowsEvent {
  final ShowModel show;

  const CreateShowEvent({required this.show});

  @override
  List<Object?> get props => [show];
}

final class EditShowEvent extends ShowsEvent {
  final ShowModel show;

  const EditShowEvent({required this.show});

  @override
  List<Object?> get props => [show];
}

final class DeleteShowEvent extends ShowsEvent {
  final String showId;
  final String? bannerUrl; // To delete banner from storage

  const DeleteShowEvent({required this.showId, this.bannerUrl});

  @override
  List<Object?> get props => [showId, bannerUrl];
}
