// lib/features/merchant/presentation/bloc/merchant_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/features/merchant/domain/usecases/create_merchant_usecase.dart';
import 'package:ticketing/features/merchant/domain/usecases/get_merchant_details_usecase.dart';
import 'merchant_event.dart';
import 'merchant_state.dart';

@injectable
class MerchantBloc extends Bloc<MerchantEvent, MerchantState> {
  final CreateMerchantUseCase _createMerchantUseCase;
  final GetMerchantDetailsUseCase _getMerchantDetailsUseCase;

  MerchantBloc(
    this._createMerchantUseCase,
    this._getMerchantDetailsUseCase,
  ) : super(const MerchantState()) {
    on<CreateMerchantEvent>(_onCreateMerchant);
    on<GetMerchantDetailsEvent>(_onGetMerchantDetails);
  }

  Future<void> _onCreateMerchant(
    CreateMerchantEvent event,
    Emitter<MerchantState> emit,
  ) async {
    emit(state.copyWith(status: MerchantStatus.loading, errorMessage: null));

    final result = await _createMerchantUseCase(
      name: event.name,
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
        errorMessage: null,
      )),
    );
  }

  Future<void> _onGetMerchantDetails(
    GetMerchantDetailsEvent event,
    Emitter<MerchantState> emit,
  ) async {
    emit(state.copyWith(status: MerchantStatus.loading, errorMessage: null));

    final result = await _getMerchantDetailsUseCase();

    result.fold(
      (failure) => emit(state.copyWith(
        status: MerchantStatus.error,
        errorMessage: failure.message,
      )),
      (merchant) => emit(state.copyWith(
        status: MerchantStatus.success,
        merchant: merchant,
        errorMessage: null,
      )),
    );
  }
}
