// lib/features/merchant/presentation/bloc/mpesa_setup/mpesa_setup_state.dart

part of 'mpesa_setup_bloc.dart';

abstract class MpesaSetupState extends Equatable {
  const MpesaSetupState();

  @override
  List<Object> get props => [];
}

class MpesaSetupInitial extends MpesaSetupState {}

class MpesaSetupLoading extends MpesaSetupState {}

class MpesaSetupSuccess extends MpesaSetupState {}

class MpesaSetupError extends MpesaSetupState {
  final String message;

  const MpesaSetupError(this.message);

  @override
  List<Object> get props => [message];
}
