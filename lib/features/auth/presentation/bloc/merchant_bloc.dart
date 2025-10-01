// lib/features/auth/presentation/bloc/merchant_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/features/auth/domain/usecases/create_merchant_usecase.dart';
import 'merchant_event.dart';
import 'merchant_state.dart';

@injectable
class MerchantBloc extends Bloc<MerchantEvent, MerchantState> {
  final CreateMerchantUseCase _createMerchantUseCase;

  MerchantBloc(this._createMerchantUseCase) : super(const MerchantState()) {
    on<CreateMerchantEvent>(_onCreateMerchant);
  }

  Future<void> _onCreateMerchant(
    CreateMerchantEvent event,
    Emitter<MerchantState> emit,
  ) async {
    emit(state.copyWith(status: MerchantStatus.loading));

    final result = await _createMerchantUseCase(
      businessName: event.businessName,
      businessEmail: event.businessEmail,
      businessTelephone: event.businessTelephone,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: MerchantStatus.error,
        errorMessage: failure.message,
      )),
      (merchant) => emit(state.copyWith(
        status: MerchantStatus.success,
        merchant: merchant,
      )),
    );
  }
}
