import 'package:equatable/equatable.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';

sealed class ShowsState extends Equatable {
  const ShowsState();

  @override
  List<Object> get props => [];
}

final class ShowsInitial extends ShowsState {}

final class ShowsLoading extends ShowsState {}

final class ShowsLoaded extends ShowsState {
  final List<ShowModel> shows;
  const ShowsLoaded({required this.shows});
  @override
  List<Object> get props => [shows];
}

final class ShowsError extends ShowsState {
  final Failure failure;
  const ShowsError({required this.failure});
  @override
  List<Object> get props => [failure];
}

final class ShowBannerUploading extends ShowsState {}

final class ShowBannerUploaded extends ShowsState {
  final String downloadUrl;
  const ShowBannerUploaded({required this.downloadUrl});
  @override
  List<Object> get props => [downloadUrl];
}

final class ShowCreating extends ShowsState {}

final class ShowCreated extends ShowsState {
  final ShowModel show;
  const ShowCreated({required this.show});
  @override
  List<Object> get props => [show];
}

final class ShowEditing extends ShowsState {}

final class ShowEdited extends ShowsState {
  final ShowModel show;
  const ShowEdited({required this.show});
  @override
  List<Object> get props => [show];
}

final class ShowDeleting extends ShowsState {}

final class ShowDeleted extends ShowsState {}
