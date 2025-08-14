part of 'tickets_bloc.dart';

abstract class TicketsState extends Equatable {
  const TicketsState();

  @override
  List<Object> get props => [];
}

class TicketsInitial extends TicketsState {}
