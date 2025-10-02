// lib/features/merchant/presentation/bloc/merchant_state.dart

import 'package:equatable/equatable.dart';
import 'package:ticketing/features/merchant/data/models/merchant_model.dart';

enum MerchantStatus {
  initial,
  loading,
  success,
  error,
}

class MerchantState extends Equatable {
  final MerchantStatus status;
  final MerchantModel? merchant;
  final String? errorMessage;

  const MerchantState({
    this.status = MerchantStatus.initial,
    this.merchant,
    this.errorMessage,
  });

  MerchantState copyWith({
    MerchantStatus? status,
    MerchantModel? merchant,
    String? errorMessage,
  }) {
    return MerchantState(
      status: status ?? this.status,
      merchant: merchant ?? this.merchant,
      errorMessage: errorMessage ??
          this.errorMessage, 
    );
  }

  @override
  List<Object?> get props => [status, merchant, errorMessage];
}
