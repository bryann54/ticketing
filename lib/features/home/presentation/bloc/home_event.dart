// lib/features/home/presentation/bloc/home_event.dart

import 'package:equatable/equatable.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {
  const LoadHomeData();
}

class CreateShow extends HomeEvent {
  final ShowModel newShow;
  const CreateShow({required this.newShow});

  @override
  List<Object> get props => [newShow];
}

class EditShow extends HomeEvent {
  final ShowModel updatedShow;
  const EditShow({required this.updatedShow});

  @override
  List<Object> get props => [updatedShow];
}

class DeleteShow extends HomeEvent {
  final int showId;
  const DeleteShow({required this.showId});

  @override
  List<Object> get props => [showId];
}
