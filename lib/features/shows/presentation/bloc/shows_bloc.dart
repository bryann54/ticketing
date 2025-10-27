// lib/features/shows/presentation/bloc/shows_bloc.dart

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/features/shows/domain/usecases/create_show_usecase.dart';
import 'package:ticketing/features/shows/domain/usecases/delete_show_banner_usecase.dart';
import 'package:ticketing/features/shows/domain/usecases/delete_show_usecase.dart';
import 'package:ticketing/features/shows/domain/usecases/edit_show_usecase.dart';
import 'package:ticketing/features/shows/domain/usecases/get_shows_usecase.dart';
import 'package:ticketing/features/shows/domain/usecases/upload_show_banner_usecase.dart';
import 'package:ticketing/features/shows/presentation/bloc/shows_event.dart';
import 'package:ticketing/features/shows/presentation/bloc/shows_state.dart';

@injectable
class ShowsBloc extends Bloc<ShowsEvent, ShowsState> {
  final GetShowsUsecase _getShowsUsecase;
  final CreateShowUsecase _createShowUsecase;
  final EditShowUsecase _editShowUsecase;
  final DeleteShowUsecase _deleteShowUsecase;
  final UploadShowBannerUsecase _uploadBannerUsecase;
  final DeleteShowBannerUsecase _deleteBannerUsecase;

  ShowsBloc(
    this._getShowsUsecase,
    this._createShowUsecase,
    this._editShowUsecase,
    this._deleteShowUsecase,
    this._uploadBannerUsecase,
    this._deleteBannerUsecase,
  ) : super(ShowsInitial()) {
    on<GetShowsEvent>(_onGetShowsEvent);
    on<UploadShowBannerEvent>(_onUploadShowBannerEvent);
    on<CreateShowEvent>(_onCreateShowEvent);
    on<EditShowEvent>(_onEditShowEvent);
    on<DeleteShowEvent>(_onDeleteShowEvent);
  }

  FutureOr<void> _onGetShowsEvent(
      GetShowsEvent event, Emitter<ShowsState> emit) async {
    emit(ShowsLoading());
    final result = await _getShowsUsecase.call(event.params);
    result.fold(
      (failure) => emit(ShowsError(failure: failure)),
      (shows) => emit(ShowsLoaded(shows: shows)),
    );
  }

  FutureOr<void> _onUploadShowBannerEvent(
    UploadShowBannerEvent event,
    Emitter<ShowsState> emit,
  ) async {
    emit(ShowBannerUploading());
    final result = await _uploadBannerUsecase.call(
      UploadShowBannerParams(
        imageFile: event.imageFile,
        showName: event.showName,
      ),
    );
    result.fold(
      (failure) => emit(ShowsError(failure: failure)),
      (url) => emit(ShowBannerUploaded(downloadUrl: url)),
    );
  }

  FutureOr<void> _onCreateShowEvent(
    CreateShowEvent event,
    Emitter<ShowsState> emit,
  ) async {
    emit(ShowCreating());
    final result = await _createShowUsecase.call(event.show);
    result.fold(
      (failure) => emit(ShowsError(failure: failure)),
      (show) => emit(ShowCreated(show: show)),
    );
  }

  FutureOr<void> _onEditShowEvent(
    EditShowEvent event,
    Emitter<ShowsState> emit,
  ) async {
    emit(ShowEditing());
    final result = await _editShowUsecase.call(event.show);
    result.fold(
      (failure) => emit(ShowsError(failure: failure)),
      (show) => emit(ShowEdited(show: show)),
    );
  }

  FutureOr<void> _onDeleteShowEvent(
    DeleteShowEvent event,
    Emitter<ShowsState> emit,
  ) async {
    emit(ShowDeleting());

    // Delete banner from storage if URL exists
    if (event.bannerUrl != null && event.bannerUrl!.isNotEmpty) {
      await _deleteBannerUsecase.call(event.bannerUrl!);
    }

    final result = await _deleteShowUsecase.call(event.showId);
    result.fold(
      (failure) => emit(ShowsError(failure: failure)),
      (_) => emit(ShowDeleted()),
    );
  }
}
