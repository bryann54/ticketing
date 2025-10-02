// lib/features/merchant/presentation/bloc/merchant_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/merchant/domain/usecases/create_merchant_usecase.dart';
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
    emit(const MerchantState(status: MerchantStatus.loading)); // Use fresh state

    final result = await _createMerchantUseCase(
      name: event.name,
      businessEmail: event.businessEmail,
      businessTelephone: event.businessTelephone,
    );

    result.fold(
      (failure) {
        String errorMessage = _getErrorMessage(failure);
        emit(MerchantState(
          status: MerchantStatus.error,
          errorMessage: errorMessage,
        ));
      },
      (merchant) => emit(MerchantState(
        status: MerchantStatus.success,
        merchant: merchant,
      )),
    );
  }

  String _getErrorMessage(Failure failure) {
    if (failure is ServerFailure) {
      switch (failure.statusCode) {
        case 500:
          return 'Server is temporarily unavailable. Please try again later.';
        case 400:
          return 'Invalid data provided. Please check your information.';
        case 401:
          return 'Authentication failed. Please log in again.';
        default:
          return failure.message ?? 'An error occurred';
      }
    }
    return failure.message ?? 'An unexpected error occurred';
  }
}