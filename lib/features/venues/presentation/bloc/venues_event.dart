import 'package:equatable/equatable.dart';

sealed class VenuesEvent extends Equatable {
  const VenuesEvent();

  @override
  List<Object> get props => [];
}

final class GetVenuesEvent extends VenuesEvent {}
