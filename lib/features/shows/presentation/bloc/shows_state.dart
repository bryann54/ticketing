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
