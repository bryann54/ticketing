// lib/features/auth/presentation/bloc/merchant_event.dart

import 'package:equatable/equatable.dart';

abstract class MerchantEvent extends Equatable {
  const MerchantEvent();

  @override
  List<Object> get props => [];
}

class CreateMerchantEvent extends MerchantEvent {
  final String businessName;
  final String businessEmail;
  final String businessTelephone;

  const CreateMerchantEvent({
    required this.businessName,
    required this.businessEmail,
    required this.businessTelephone,
  });

  @override
  List<Object> get props => [businessName, businessEmail, businessTelephone];
}
