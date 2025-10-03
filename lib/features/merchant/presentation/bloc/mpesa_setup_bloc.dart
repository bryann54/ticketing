// lib/features/merchant/presentation/bloc/mpesa_setup/mpesa_setup_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart'; // Add this import
import 'package:ticketing/features/merchant/domain/usecases/add_mpesa_details.dart';

part 'mpesa_setup_event.dart';
part 'mpesa_setup_state.dart';

@injectable // Add this annotation
class MpesaSetupBloc extends Bloc<MpesaSetupEvent, MpesaSetupState> {
  final AddMpesaDetails addMpesaDetails;

  MpesaSetupBloc({required this.addMpesaDetails}) : super(MpesaSetupInitial()) {
    on<AddMpesaDetailsEvent>((event, emit) async {
      emit(MpesaSetupLoading());

      final result = await addMpesaDetails(AddMpesaDetailsParams(
        consumerKey: event.consumerKey,
        consumerSecret: event.consumerSecret,
        shortCode: event.shortCode,
        passKey: event.passKey,
        integrationType: event.integrationType,
        partyB: event.partyB,
      ));

      result.fold(
        (failure) => emit(MpesaSetupError(failure.message ?? 'Unknown error')),
        (_) => emit(MpesaSetupSuccess()),
      );
    });
  }
}
