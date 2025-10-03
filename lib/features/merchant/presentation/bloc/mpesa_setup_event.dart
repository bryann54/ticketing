// lib/features/merchant/presentation/bloc/mpesa_setup/mpesa_setup_event.dart

part of 'mpesa_setup_bloc.dart';

abstract class MpesaSetupEvent extends Equatable {
  const MpesaSetupEvent();

  @override
  List<Object> get props => [];
}

class AddMpesaDetailsEvent extends MpesaSetupEvent {
  final String consumerKey;
  final String consumerSecret;
  final String shortCode;
  final String passKey;
  final String integrationType;
  final String partyB;

  const AddMpesaDetailsEvent({
    required this.consumerKey,
    required this.consumerSecret,
    required this.shortCode,
    required this.passKey,
    required this.integrationType,
    required this.partyB,
  });

  @override
  List<Object> get props => [
        consumerKey,
        consumerSecret,
        shortCode,
        passKey,
        integrationType,
        partyB,
      ];
}
